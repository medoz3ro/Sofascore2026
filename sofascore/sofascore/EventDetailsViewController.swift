import SnapKit
import SofaAcademic
import UIKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let eventDetailsView = EventDetailsView()
    private let event: Event
    private let sport: Sport

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
        loadData()
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(eventDetailsView)
    }

    func styleViews() {
        view.backgroundColor = .systemBackground
        safeAreaBackgroundView.backgroundColor = .systemBackground
        safeAreaBackgroundView.isUserInteractionEnabled = false
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
    }
}
