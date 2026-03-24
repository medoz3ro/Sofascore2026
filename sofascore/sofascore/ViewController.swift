import SnapKit
import SofaAcademic
import UIKit

nonisolated enum Section: Hashable, Sendable {
    case league(Int)
}

nonisolated enum Item: Hashable, Sendable {
    case match(Int)
}

class ViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let statusBarView = StatusBarView()
    private let sportSelectorView = SportSelectorView()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var leagueViewModels: [Int: LeagueViewModel] = [:]
    private var matchViewModels: [Int: MatchViewModel] = [:]
    private var eventsById: [Int: Event] = [:]
    private var leagues: [Int: League] = [:]
    private var diffableDataSource:
        UICollectionViewDiffableDataSource<Section, Item>?
    private var selectedTheme: Theme = .light

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupDataSource()
        setupBinding()
        loadData()
    }

    func setupBinding() {
        sportSelectorView.onSportSelected = { index in
            // TODO: load data for selected sport
        }

        statusBarView.onSettingsTapped = { [weak self] in
            guard let self else { return }
            let settingsVC = SettingsViewController(
                selectedTheme: self.selectedTheme
            )
            settingsVC.modalPresentationStyle = .fullScreen
            settingsVC.onThemeChanged = { [weak self] theme in
                self?.selectedTheme = theme
            }
            self.present(settingsVC, animated: true)
        }
    }

    func loadData() {
        sportSelectorView.configure(with: .defaultSports())
        let dataSource = Homework3DataSource()

        let events = dataSource.events().filter { $0.league != nil }
        events.forEach { eventsById[$0.id] = $0 }

        let grouped = Dictionary(grouping: events, by: { $0.league?.id ?? 0 })

        grouped.forEach { leagueId, leagueEvents in
            if let league = leagueEvents.first?.league {
                leagues[leagueId] = league
            }
        }

        Task { [weak self] in
            guard let self else { return }
            await self.loadLeagueViewModels()
            await self.loadMatchViewModels(for: events)
            self.applySnapshot(grouped: grouped)
        }
    }

    private func applySnapshot(grouped: [Int: [Event]]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

        grouped.keys.sorted().forEach { leagueId in
            snapshot.appendSections([.league(leagueId)])
            let items = grouped[leagueId]?.map { Item.match($0.id) } ?? []
            snapshot.appendItems(items, toSection: .league(leagueId))
        }
        diffableDataSource?.apply(snapshot)
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(statusBarView)
        view.addSubview(sportSelectorView)
        view.addSubview(collectionView)
    }

    func styleViews() {
        view.backgroundColor = .systemBackground

        safeAreaBackgroundView.backgroundColor = .primaryDefault

        collectionView.register(
            MatchCell.self,
            forCellWithReuseIdentifier: "MatchCell"
        )
        collectionView.register(
            LeagueHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView
                .elementKindSectionHeader,
            withReuseIdentifier: "LeagueHeader"
        )
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width, height: 56)
        layout.headerReferenceSize = CGSize(
            width: view.bounds.width,
            height: 56
        )
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }

    func setupConstraints() {
        safeAreaBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        statusBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        sportSelectorView.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sportSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func loadLeagueViewModels() async {
        for (leagueId, league) in leagues {
            let logo = await downloadImage(from: league.logoUrl ?? "")
            leagueViewModels[leagueId] = LeagueViewModel(
                league: league,
                logo: logo
            )
        }
    }

    private func loadMatchViewModels(for events: [Event]) async {
        for event in events {
            let homeImage = await downloadImage(
                from: event.homeTeam.logoUrl ?? ""
            )
            let awayImage = await downloadImage(
                from: event.awayTeam.logoUrl ?? ""
            )
            matchViewModels[event.id] = MatchViewModel(
                event: event,
                homeTeamLogo: homeImage,
                awayTeamLogo: awayImage
            )
        }
    }

    private func setupDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
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

        diffableDataSource?.supplementaryViewProvider = {
            collectionView,
            kind,
            indexPath in
            guard
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "LeagueHeader",
                    for: indexPath
                ) as? LeagueHeaderView
            else { return UICollectionReusableView() }

            if let section = self.diffableDataSource?.snapshot()
                .sectionIdentifiers[indexPath.section],
                case .league(let leagueId) = section,
                let viewModel = self.leagueViewModels[leagueId]
            {
                header.configure(with: viewModel)
            }
            return header
        }
    }

    private func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        guard let (data, _) = try? await URLSession.shared.data(from: url)
        else { return nil }
        return UIImage(data: data)
    }
}
