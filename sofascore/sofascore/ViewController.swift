import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    private let leagueView = LeagueView()
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        let dataSource = Homework2DataSource()
        let league = dataSource.laLigaLeague()
        
        let leagueViewModel = LeagueViewModel(league: league, logo: nil)
        leagueView.configure(with: leagueViewModel)
        
        if let urlString = league.logoUrl, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    let updatedViewModel = LeagueViewModel(league: league, logo: image)
                    self.leagueView.configure(with: updatedViewModel)
                }
            }.resume()
        }
        
        
        dataSource.laLigaEvents()
            .sorted { $0.startTimestamp < $1.startTimestamp }
            .forEach { event in
                let eventView = MatchView()
                let viewModel = MatchViewModel(event: event, homeTeamLogo: nil, awayTeamLogo: nil)
                eventView.configure(with: viewModel)
                stackView.addArrangedSubview(eventView)
                
                var homeImage: UIImage? = nil
                var awayImage: UIImage? = nil
                
                if let urlString = event.homeTeam.logoUrl, let url = URL(string: urlString) {
                    URLSession.shared.dataTask(with: url) { data, _, _ in
                        guard let data = data, let image = UIImage(data: data) else { return }
                        homeImage = image
                        DispatchQueue.main.async {
                            let updatedViewModel = MatchViewModel(event: event, homeTeamLogo: homeImage, awayTeamLogo: awayImage)
                            eventView.configure(with: updatedViewModel)
                        }
                    }.resume()
                }
                
                if let urlString = event.awayTeam.logoUrl, let url = URL(string: urlString) {
                    URLSession.shared.dataTask(with: url) { data, _, _ in
                        guard let data = data, let image = UIImage(data: data) else { return }
                        awayImage = image
                        DispatchQueue.main.async {
                            let updatedViewModel = MatchViewModel(event: event, homeTeamLogo: homeImage, awayTeamLogo: awayImage)
                            eventView.configure(with: updatedViewModel)
                        }
                    }.resume()
                }
            }
    }
    
    private func setupUI() {
        view.addSubview(leagueView)
        //        leagueView.backgroundColor = .red
        leagueView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        //        view.addSubview(matchView)
        //        matchView.snp.makeConstraints { make in
        //            make.top.equalTo(leagueView.snp.bottom).offset(32)
        //            make.leading.trailing.equalToSuperview()
        //        }
        
    }
    
}
