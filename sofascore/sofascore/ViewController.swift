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
    private var selectedSport: Sport = .football
    
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
        sportSelectorView.onSportSelected = { [weak self] sport in
            self?.selectedSport = sport
        }

        statusBarView.onSettingsTapped = { [weak self] in
            guard let self else { return }
            let settingsVC = SettingsViewController()
            settingsVC.modalPresentationStyle = .fullScreen
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
            guard let logoUrl = league.logoUrl else { continue }
            let logo = await URLSession.shared.downloadImage(from: logoUrl)
            leagueViewModels[leagueId] = LeagueViewModel(
                league: league,
                logo: logo
            )
        }
    }

    private func loadMatchViewModels(for events: [Event]) async {
        for event in events {
            let homeImage =
                if let url = event.homeTeam.logoUrl {
                    await URLSession.shared.downloadImage(from: url)
                } else { nil as UIImage? }

            let awayImage =
                if let url = event.awayTeam.logoUrl {
                    await URLSession.shared.downloadImage(from: url)
                } else { nil as UIImage? }

            matchViewModels[event.id] = MatchViewModel(
                event: event,
                homeTeamLogo: homeImage,
                awayTeamLogo: awayImage,
                matchTapHandler: { [weak self] in
                    guard let self, let event = self.eventsById[event.id] else { return }
                    let detailsVC = EventDetailsViewController(
                        event: event,
                        sport: self.selectedSport
                    )
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
            )
        }
    }

    private func setupDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView
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

        diffableDataSource?.supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            guard let self else { return UICollectionReusableView() }
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
}
