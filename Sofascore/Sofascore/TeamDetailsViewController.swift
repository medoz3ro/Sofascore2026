import SnapKit
import SofaAcademic
import UIKit

class TeamDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let headerView = DetailHeaderView()
    private let teamSelectorView = TeamSelectorView()
    private let teamInfoView = TeamInfoView()
    private let playersView = UIView()

    private let teamId: Int
    private var selectedTab: TeamTab = .details
    private let sport: Sport

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
        setupBinding()
        loadData()
        selectTab(.details)
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(teamSelectorView)
        view.addSubview(playersView)
        view.addSubview(teamInfoView)
    }

    func styleViews() {
        view.backgroundColor = .onSurface0
        safeAreaBackgroundView.backgroundColor = .primaryDefault
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

        playersView.snp.makeConstraints { make in
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
                let teamInfo = try await viewModel.fetchTeamInfo()
                let players = try await viewModel.fetchPlayers()
                let tournaments = try await viewModel.fetchTournaments()

                var headerViewModel = DetailHeaderViewModel(
                    title: teamInfo.team.name,
                    subtitle: teamInfo.team.country?.name ?? "",
                    logoUrl: teamInfo.team.logoUrl
                )
                headerViewModel.flagUrl = CountryFlagOverride.flagUrl(
                    for: teamInfo.team.country?.name ?? ""
                )
                self.headerView.configure(with: headerViewModel)

                var infoViewModel = TeamInfoViewModel(
                    teamInfo: teamInfo,
                    players: players,
                    tournaments: tournaments
                )
                
                infoViewModel.managerFlagUrl = CountryFlagOverride.flagUrl(
                    for: teamInfo.manager?.country?.name ?? ""
                )
                self.teamInfoView.configure(with: infoViewModel)
            } catch {
                print("Error fetching team info: \(error)")
            }
        }
    }

    private func selectTab(_ tab: TeamTab) {
        selectedTab = tab
        teamSelectorView.selectTab(tab)
        teamInfoView.isHidden = tab != .details
        playersView.isHidden = tab != .players
    }
}
