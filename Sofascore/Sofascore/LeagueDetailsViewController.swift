import SnapKit
import SofaAcademic
import UIKit

nonisolated enum LeagueMatchSection: Hashable, Sendable {
    case round(Int)
}

nonisolated enum LeagueMatchItem: Hashable, Sendable {
    case match(Int)
}

class LeagueDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let headerView = LeagueHeaderDetailView()
    private let leagueSelectorView = LeagueSelectorView()
    private let matchesCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let standingsCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private let league: League
    private let sport: Sport
    private var selectedTab: LeagueTab = .matches
    private var matchViewModels: [Int: MatchViewModel] = [:]
    private var matchesDiffableDataSource:
        UICollectionViewDiffableDataSource<LeagueMatchSection, LeagueMatchItem>?

    private var standingsViewModels: [StandingsViewModel] = []
    private var standingsDiffableDataSource:
        UICollectionViewDiffableDataSource<Int, Int>?
    private let standingsHeaderView = StandingsHeaderView()

    init(league: League, sport: Sport) {
        self.league = league
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
        selectTab(.matches)
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(leagueSelectorView)
        view.addSubview(standingsHeaderView)
        view.addSubview(matchesCollectionView)
        view.addSubview(standingsCollectionView)
    }

    func styleViews() {
        view.backgroundColor = .onSurface0
        safeAreaBackgroundView.backgroundColor = .primaryDefault

        matchesCollectionView.register(
            MatchCell.self,
            forCellWithReuseIdentifier: "MatchCell"
        )
        matchesCollectionView.register(
            RoundHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView
                .elementKindSectionHeader,
            withReuseIdentifier: "RoundHeader"
        )

        let matchesLayout = UICollectionViewFlowLayout()
        matchesLayout.scrollDirection = .vertical
        matchesLayout.itemSize = CGSize(width: view.bounds.width, height: 56)
        matchesLayout.headerReferenceSize = CGSize(
            width: view.bounds.width,
            height: 48
        )
        matchesLayout.minimumLineSpacing = 0
        matchesCollectionView.collectionViewLayout = matchesLayout
        matchesCollectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 16,
            right: 0
        )
        matchesCollectionView.backgroundColor = .onSurface0

        standingsCollectionView.backgroundColor = .onSurface0
        standingsCollectionView.register(
            StandingsCell.self,
            forCellWithReuseIdentifier: "StandingsCell"
        )
        let standingsLayout = UICollectionViewFlowLayout()
        standingsLayout.scrollDirection = .vertical
        standingsLayout.itemSize = CGSize(width: view.bounds.width, height: 48)
        standingsLayout.minimumLineSpacing = 0
        standingsCollectionView.collectionViewLayout = standingsLayout
        standingsCollectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 16,
            right: 0
        )
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

        leagueSelectorView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        standingsHeaderView.snp.makeConstraints { make in
            make.top.equalTo(leagueSelectorView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        standingsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(standingsHeaderView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        matchesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(leagueSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupDataSource() {
        matchesDiffableDataSource = UICollectionViewDiffableDataSource<
            LeagueMatchSection, LeagueMatchItem
        >(
            collectionView: matchesCollectionView
        ) { [weak self] collectionView, indexPath, item in
            guard let self else { return UICollectionViewCell() }
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "MatchCell",
                    for: indexPath
                ) as? MatchCell
            else { return UICollectionViewCell() }

            switch item {
            case .match(let id):
                if let viewModel = self.matchViewModels[id] {
                    cell.configure(with: viewModel)
                }
            }
            return cell
        }

        matchesDiffableDataSource?.supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            guard let self else { return UICollectionReusableView() }
            guard
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "RoundHeader",
                    for: indexPath
                ) as? RoundHeaderView
            else { return UICollectionReusableView() }

            if let section = self.matchesDiffableDataSource?.snapshot()
                .sectionIdentifiers[indexPath.section],
                case .round(let round) = section
            {
                header.configure(with: "\(String.round) \(round)")
            }
            return header
        }

        standingsDiffableDataSource = UICollectionViewDiffableDataSource<
            Int, Int
        >(
            collectionView: standingsCollectionView
        ) { [weak self] collectionView, indexPath, index in
            guard let self else { return UICollectionViewCell() }
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "StandingsCell",
                    for: indexPath
                ) as? StandingsCell
            else { return UICollectionViewCell() }
            cell.configure(with: self.standingsViewModels[index])
            return cell
        }
    }

    private func setupBinding() {
        leagueSelectorView.onTabSelected = { [weak self] tab in
            self?.selectTab(tab)
        }

        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }

    private func loadData() {
        let detailsViewModel = LeagueDetailsViewModel(
            league: league,
            sport: sport
        )

        headerView.configure(with: LeagueHeaderDetailViewModel(league: league))

        Task { @MainActor [weak self] in
            guard let self else { return }
            let headerViewModel = await detailsViewModel.fetchHeaderViewModel()
            self.headerView.configure(with: headerViewModel)
        }

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let events = try await APIClient.fetchLeagueMatches(
                    leagueId: league.id
                )
                self.onMatchesLoaded(events)
            } catch {
                print("Error fetching matches: \(error)")
            }
        }

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let standings = try await APIClient.fetchLeagueStandings(
                    leagueId: league.id
                )
                self.standingsViewModels = standings.map {
                    StandingsViewModel(standings: $0)
                }
                var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
                snapshot.appendSections([0])
                snapshot.appendItems(Array(self.standingsViewModels.indices))
                await self.standingsDiffableDataSource?.apply(snapshot)
            } catch {
                print("Error fetching standings: \(error)")
            }
        }
        standingsHeaderView.configure(
            with: StandingsHeaderViewModel.make(for: sport)
        )
    }

    private func onMatchesLoaded(_ events: [Event]) {
        let grouped = Dictionary(grouping: events, by: { $0.round ?? 0 })

        grouped.forEach { _, roundEvents in
            roundEvents.forEach { event in
                matchViewModels[event.id] = MatchViewModel(event: event)
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<
            LeagueMatchSection, LeagueMatchItem
        >()
        grouped.keys.sorted().forEach { round in
            snapshot.appendSections([.round(round)])
            let items =
                grouped[round]?.map { LeagueMatchItem.match($0.id) } ?? []
            snapshot.appendItems(items, toSection: .round(round))
        }
        matchesDiffableDataSource?.apply(snapshot)
    }

    private func selectTab(_ tab: LeagueTab) {
        selectedTab = tab
        leagueSelectorView.selectTab(tab)
        standingsHeaderView.isHidden = tab != .standings
        matchesCollectionView.isHidden = tab != .matches
        standingsCollectionView.isHidden = tab != .standings
    }
}
