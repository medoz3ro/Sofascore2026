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
            let leagueLogo: UIImage?
            if let url = event.league?.logoUrl {
                leagueLogo = await URLSession.shared.downloadImage(from: url)
            } else {
                leagueLogo = nil
            }

            let homeTeamLogo: UIImage?
            if let url = event.homeTeam.logoUrl {
                homeTeamLogo = await URLSession.shared.downloadImage(from: url)
            } else {
                homeTeamLogo = nil
            }

            let awayTeamLogo: UIImage?
            if let url = event.awayTeam.logoUrl {
                awayTeamLogo = await URLSession.shared.downloadImage(from: url)
            } else {
                awayTeamLogo = nil
            }
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
