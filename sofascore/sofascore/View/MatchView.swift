//
//   MatchView.swift
//  Sofascore
//
//  Created by Benjamin on 10.03.2026..
//
import UIKit
import SnapKit
import SofaAcademic

class MatchView: UIView{
    private let homeTeam : UILabel = UILabel()
    private let homeTeamLogo : UIImageView = UIImageView()
    private let awayTeam : UILabel = UILabel()
    private let awayTeamLogo : UIImageView = UIImageView()
    private let status : UILabel = UILabel()
    private let startTimestamp : UILabel = UILabel()
    private let homeScore : UILabel = UILabel()
    private let awayScore : UILabel = UILabel()
    private let divider: UIView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    func configure(with event: Event) {
        homeTeam.text = event.homeTeam.name
        
        guard let homeTeamLogoUrl = event.homeTeam.logoUrl, let url = URL(string: homeTeamLogoUrl) else { return }
        
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data, let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.homeTeamLogo.image = image
                    }
                }.resume()
        
        awayTeam.text = event.awayTeam.name
        
        guard let awayTeamLogoUrl = event.awayTeam.logoUrl, let url = URL(string: awayTeamLogoUrl) else { return }
        
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data, let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.awayTeamLogo.image = image
                    }
                }.resume()
        
        switch event.status {
        case .notStarted:
            status.text = "-"
        case .inProgress:
            let elapsed = Int((Date().timeIntervalSince1970 - Double(event.startTimestamp)) / 60)
            status.text = "\(elapsed)'"
        case .halftime:
            status.text = "HT"
        case .finished:
            status.text = "FT"
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        
        startTimestamp.text = formatter.string(from: date)
        
        homeScore.text = event.homeScore.map { "\($0)" }
        awayScore.text = event.awayScore.map {"\($0)"}
    }
    
    
    
    private func setupUI(){
        
        
        addSubview(startTimestamp)
        startTimestamp.textAlignment = .center
        startTimestamp.font = AppFont.micro(size: 16)
        startTimestamp.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.width.equalTo(56)
            make.bottom.equalTo(snp.centerY).offset(-4)
        }
        addSubview(status)
        status.textAlignment = .center
        status.font = AppFont.micro(size: 16)
        status.snp.makeConstraints { (make) in
            make.top.equalTo(startTimestamp.snp.bottom).offset(4)
            make.centerX.equalTo(startTimestamp)
        }
        
        
        addSubview(divider)
        divider.backgroundColor = .gray
        divider.snp.makeConstraints{ (make) in
            make.width.equalTo(3)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.leading.equalTo(startTimestamp.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        
        addSubview(homeTeamLogo)
        homeTeamLogo.snp.makeConstraints { (make) in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.top.equalToSuperview()
            make.size.equalTo(16)
        }
        addSubview(homeTeam)
        homeTeam.font = AppFont.regular(size: 16)
        homeTeam.snp.makeConstraints { (make) in
            make.leading.equalTo(homeTeamLogo.snp.trailing).offset(16)
            make.top.equalToSuperview()
        }
        homeTeamLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(homeTeam)
        }
        
        addSubview(awayTeamLogo)
        awayTeamLogo.snp.makeConstraints { (make) in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.top.equalTo(homeTeamLogo.snp.bottom).offset(8)
            make.size.equalTo(16)
        }
        
        addSubview(awayTeam)
        awayTeam.font = AppFont.regular(size: 16)
        awayTeam.snp.makeConstraints { (make) in
            make.leading.equalTo(awayTeamLogo.snp.trailing).offset(16)
            make.top.equalTo(homeTeam.snp.bottom).offset(8)
        }
        awayTeamLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(awayTeam)
        }
        
        
        addSubview(homeScore)
        homeScore.font = AppFont.regular(size: 16)
        homeScore.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.centerY.equalTo(homeTeam)
        }
        
        addSubview(awayScore)
        awayScore.font = AppFont.regular(size: 16)
        awayScore.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview( ).inset(16)
            make.top.equalTo(homeScore.snp.bottom).offset(8)
            make.centerY.equalTo(awayTeam)
        }
   
        startTimestamp.snp.makeConstraints { (make) in
            make.centerY.equalTo(homeTeam)
        }
        status.snp.makeConstraints { (make) in
            make.centerY.equalTo(awayTeam)
        }
        
        
        
    }
    
}
