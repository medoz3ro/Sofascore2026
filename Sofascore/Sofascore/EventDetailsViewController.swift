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
        setupBinding()
        loadData()
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(eventDetailsView)
    }

    func styleViews() {
        view.backgroundColor = .systemBackground
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
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func loadData() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let leagueLogo =
                if let url = event.league?.logoUrl {
                    await URLSession.shared.downloadImage(from: url)
                } else { nil as UIImage? }

            let homeTeamLogo =
                if let url = event.homeTeam.logoUrl {
                    await URLSession.shared.downloadImage(from: url)
                } else { nil as UIImage? }

            let awayTeamLogo =
                if let url = event.awayTeam.logoUrl {
                    await URLSession.shared.downloadImage(from: url)
                } else { nil as UIImage? }
            let viewModel = EventDetailsViewModel(
                event: event,
                sport: sport,
                leagueLogo: leagueLogo,
                homeTeamLogo: homeTeamLogo,
                awayTeamLogo: awayTeamLogo
            )
            self.eventDetailsView.configure(with: viewModel)
        }
    }
}
