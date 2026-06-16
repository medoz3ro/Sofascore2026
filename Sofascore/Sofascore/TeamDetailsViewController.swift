import SnapKit
import SofaAcademic
import UIKit

class TeamDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let headerView = DetailHeaderView()
    private let teamSelectorView = TeamSelectorView()
    private let teamInfoView = TeamInfoView()
    private let playersCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private let teamId: Int
    private var selectedTab: TeamTab = .details
    private let sport: Sport

    private var playerViewModels: [PlayerViewModel] = []
    private var playersDiffableDataSource:
        UICollectionViewDiffableDataSource<Int, Int>?
    private var teamInfo: TeamInfo?

    init(teamId: Int, sport: Sport) {
        self.teamId = teamId
        self.sport = sport
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupDataSource()
        setupBinding()
        loadData()
        selectTab(.details)
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(teamSelectorView)
        view.addSubview(playersCollectionView)
        view.addSubview(teamInfoView)
    }

    func styleViews() {
        view.backgroundColor = .onSurface0
        safeAreaBackgroundView.backgroundColor = .primaryDefault

        playersCollectionView.backgroundColor = .onSurface0
        playersCollectionView.register(
            PlayerCell.self,
            forCellWithReuseIdentifier: "PlayerCell"
        )
        let playersLayout = UICollectionViewFlowLayout()
        playersLayout.scrollDirection = .vertical
        playersLayout.itemSize = CGSize(width: view.bounds.width, height: 56)
        playersLayout.minimumLineSpacing = 0
        playersCollectionView.collectionViewLayout = playersLayout
    }

    func setupConstraints() {
        safeAreaBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        teamSelectorView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        playersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(teamSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        teamInfoView.snp.makeConstraints { make in
            make.top.equalTo(teamSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupBinding() {
        teamSelectorView.onTabSelected = { [weak self] tab in
            self?.selectTab(tab)
        }

        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func loadData() {
        let viewModel = TeamDetailsViewModel(teamId: teamId)

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let fetchedTeamInfo = try await viewModel.fetchTeamInfo()
                self.teamInfo = fetchedTeamInfo
                let players = try await viewModel.fetchPlayers()
                let tournaments = try await viewModel.fetchTournaments()

                var headerViewModel = DetailHeaderViewModel(
                    title: fetchedTeamInfo.team.name,
                    subtitle: fetchedTeamInfo.team.country?.name ?? "",
                    logoUrl: fetchedTeamInfo.team.logoUrl
                )
                headerViewModel.flagUrl = CountryFlagOverride.flagUrl(
                    for: fetchedTeamInfo.team.country?.name ?? ""
                )
                self.headerView.configure(with: headerViewModel)

                var infoViewModel = TeamInfoViewModel(
                    teamInfo: fetchedTeamInfo,
                    players: players,
                    tournaments: tournaments
                )
                infoViewModel.managerFlagUrl = CountryFlagOverride.flagUrl(
                    for: fetchedTeamInfo.manager?.country?.name ?? ""
                )
                self.teamInfoView.configure(with: infoViewModel)

                self.playerViewModels = players.map {
                    PlayerViewModel(player: $0)
                }
                var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
                snapshot.appendSections([0])
                snapshot.appendItems(Array(self.playerViewModels.indices))
                await self.playersDiffableDataSource?.apply(snapshot)
            } catch {
                print("Error fetching team info: \(error)")
            }
        }
    }

    private func setupDataSource() {
        playersDiffableDataSource = UICollectionViewDiffableDataSource<
            Int, Int
        >(
            collectionView: playersCollectionView
        ) { [weak self] collectionView, indexPath, index in
            guard let self else { return UICollectionViewCell() }
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "PlayerCell",
                    for: indexPath
                ) as? PlayerCell
            else { return UICollectionViewCell() }
            cell.onPlayerTapped = { [weak self] in
                guard let self else { return }
                self.navigateToPlayerDetails(
                    player: self.playerViewModels[index]
                )
            }
            cell.configure(with: self.playerViewModels[index])
            return cell
        }
    }

    private func selectTab(_ tab: TeamTab) {
        selectedTab = tab
        teamSelectorView.selectTab(tab)
        teamInfoView.isHidden = tab != .details
        playersCollectionView.isHidden = tab != .players
    }

    private func navigateToPlayerDetails(player: PlayerViewModel) {
        guard let teamInfo else { return }
        let playerViewModel = PlayerDetailsViewModel(
            player: player,
            teamInfo: teamInfo
        )
        let playerDetailsVC = PlayerDetailsViewController(
            viewModel: playerViewModel
        )
        navigationController?.pushViewController(
            playerDetailsVC,
            animated: true
        )
    }
}
