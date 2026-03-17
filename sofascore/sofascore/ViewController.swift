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
    private let sportSelectorView = SportSelectorView()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var events: [Event] = []
    private var leagues: [Int: League] = [:]

    private var diffableDataSource:
        UICollectionViewDiffableDataSource<Section, Item>?

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupDataSource()
        loadData()
    }

    func loadData() {
        sportSelectorView.configure(with: .defaultSports())
        let dataSource = Homework3DataSource()

        events = dataSource.events()
        let grouped = Dictionary(grouping: events, by: { $0.league?.id ?? 0 })

        grouped.forEach { leagueId, leagueEvents in
            if let league = leagueEvents.first?.league {
                leagues[leagueId] = league
            }
        }

        applySnapshot(grouped: grouped)
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
        view.addSubview(sportSelectorView)
        view.addSubview(collectionView)
    }

    func styleViews() {
        view.backgroundColor = .systemBackground

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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 56)
        layout.headerReferenceSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 56
        )
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.collectionViewLayout = layout
    }

    func setupConstraints() {
        sportSelectorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sportSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
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
                if let event = self.events.first(where: { $0.id == id }) {
                    let viewModel = MatchViewModel(
                        event: event,
                        homeTeamLogo: nil,
                        awayTeamLogo: nil
                    )
                    cell.configure(with: viewModel)

                    Task {
                        let homeImage = await self.downloadImage(
                            from: event.homeTeam.logoUrl ?? ""
                        )
                        let awayImage = await self.downloadImage(
                            from: event.awayTeam.logoUrl ?? ""
                        )
                        let updatedViewModel = MatchViewModel(
                            event: event,
                            homeTeamLogo: homeImage,
                            awayTeamLogo: awayImage
                        )
                        cell.configure(with: updatedViewModel)
                    }
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
                let league = self.leagues[leagueId]
            {
                let viewModel = LeagueViewModel(league: league, logo: nil)
                header.configure(with: viewModel)

                Task {
                    let logo = await self.downloadImage(
                        from: league.logoUrl ?? ""
                    )
                    let updatedViewModel = LeagueViewModel(
                        league: league,
                        logo: logo
                    )
                    header.configure(with: updatedViewModel)
                }
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
