import SnapKit
import SofaAcademic
import UIKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let eventDetailsView = EventDetailsView()
    private let event: Event
    private let sport: String

    init(event: Event, sport: String) {
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
        setupBinding()
        loadData()
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(eventDetailsView)
    }

    func styleViews() {
        safeAreaBackgroundView.backgroundColor = .systemBackground
    }

    func setupConstraints() {
        safeAreaBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        eventDetailsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupBinding() {
        eventDetailsView.onBackTapped = { [weak self] in
            self?.dismiss(animated: true)
        }
    }

    private func loadData() {
        Task { [weak self] in
            guard let self else { return }
            let leagueLogo = await URLSession.shared.downloadImage(
                from: event.league?.logoUrl ?? ""
            )
            let homeTeamLogo = await URLSession.shared.downloadImage(
                from: event.homeTeam.logoUrl ?? ""
            )
            let awayTeamLogo = await URLSession.shared.downloadImage(
                from: event.awayTeam.logoUrl ?? ""
            )
            let viewModel = EventDetailsViewModel(
                event: event,
                sport: sport,
                leagueLogo: leagueLogo,
                homeTeamLogo: homeTeamLogo,
                awayTeamLogo: awayTeamLogo
            )
            eventDetailsView.configure(with: viewModel)
        }
    }
}
