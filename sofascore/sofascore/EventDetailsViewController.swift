import SnapKit
import SofaAcademic
import UIKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let eventDetailsView = EventDetailsView()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let event: Event
    private let sport: Sport
    private var displayItems: [IncidentDisplayItem] = []
    private var diffableDataSource:
        UICollectionViewDiffableDataSource<Int, Int>?

    init(event: Event, sport: Sport) {
        self.event = event
        self.sport = sport
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupDataSource()
        loadData()
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(eventDetailsView)
        view.addSubview(collectionView)
    }

    func styleViews() {
        view.backgroundColor = .onSurface0
        safeAreaBackgroundView.backgroundColor = .systemBackground
        safeAreaBackgroundView.isUserInteractionEnabled = false

        collectionView.backgroundColor = .onSurface0
        collectionView.register(
            IncidentCell.self,
            forCellWithReuseIdentifier: "IncidentCell"
        )
        collectionView.register(
            PeriodCell.self,
            forCellWithReuseIdentifier: "PeriodCell"
        )
        collectionView.delegate = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(
            top: 8,
            left: 0,
            bottom: 0,
            right: 0
        )
    }

    func setupConstraints() {
        safeAreaBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        eventDetailsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(eventDetailsView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Int, Int>(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, index in
            guard let self else { return UICollectionViewCell() }

            switch self.displayItems[index] {
            case .incident(let viewModel):
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "IncidentCell",
                        for: indexPath
                    ) as? IncidentCell
                else { return UICollectionViewCell() }
                cell.configure(with: viewModel)
                return cell

            case .period(let viewModel):
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "PeriodCell",
                        for: indexPath
                    ) as? PeriodCell
                else { return UICollectionViewCell() }
                cell.configure(with: viewModel)
                return cell
            }
        }
    }

    private func loadData() {
        let viewModel = EventDetailsViewModel(
            event: event,
            sport: sport,
            backTapHandler: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        )
        eventDetailsView.configure(with: viewModel)
        loadIncidents()
    }

    private func loadIncidents() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let incidents = try await APIClient.fetchIncidents(
                    eventId: event.id
                )
                self.displayItems =
                    EventDetailsIncidentsViewModel.buildDisplayItems(
                        from: incidents,
                        sport: sport,
                        status: event.status
                    )
                self.applySnapshot()
            } catch {
                print("Error fetching incidents: \(error)")
            }
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(displayItems.indices))
        diffableDataSource?.apply(snapshot)
    }
}

extension EventDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch displayItems[indexPath.item] {
        case .incident(let viewModel):
            let height: CGFloat = viewModel.isBasketball ? 40 : 56
            return CGSize(width: collectionView.bounds.width, height: height)
        case .period:
            return CGSize(width: collectionView.bounds.width, height: 40)
        }
    }
}
