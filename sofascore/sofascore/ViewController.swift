import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    private let leagueView = LeagueView()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        loadData()
    }
    func loadData() {
        let dataSource = Homework2DataSource()
        let league = dataSource.laLigaLeague()
        
        Task {
            var leagueLogo: UIImage? = nil
            if let urlString = league.logoUrl {
                leagueLogo = await downloadImage(from: urlString)
            }
            
            let leagueViewModel = LeagueViewModel(league: league, logo: leagueLogo)
            leagueView.configure(with: leagueViewModel)
        }
        
        for event in dataSource.laLigaEvents().sorted(by: { $0.startTimestamp < $1.startTimestamp }) {
            let eventView = MatchView()
            let viewModel = MatchViewModel(event: event, homeTeamLogo: nil, awayTeamLogo: nil)
            eventView.configure(with: viewModel)
            stackView.addArrangedSubview(eventView)
            
            Task {
                let homeImage = await downloadImage(from: event.homeTeam.logoUrl ?? "")
                let awayImage = await downloadImage(from: event.awayTeam.logoUrl ?? "")
                let updatedViewModel = MatchViewModel(
                    event: event,
                    homeTeamLogo: homeImage,
                    awayTeamLogo: awayImage
                )
                eventView.configure(with: updatedViewModel)
            }
        }
    }
    
    private func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { return nil }
        return UIImage(data: data)
    }
    
    func addViews() {
        view.addSubview(leagueView)
        view.addSubview(stackView)
    }
    
    func styleViews() {
        view.backgroundColor = .systemBackground
        stackView.axis = .vertical
    }
    
    func setupConstraints() {
        leagueView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
