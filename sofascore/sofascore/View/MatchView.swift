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
    
    
    func configure(with viewModel: MatchViewModel) {
        homeTeam.text = viewModel.homeTeamName
        awayTeam.text = viewModel.awayTeamName
        homeScore.text = viewModel.homeScore
        awayScore.text = viewModel.awayScore
        startTimestamp.text = viewModel.time
        status.text = viewModel.status
        homeScore.textColor = viewModel.homeScoreColor
        awayScore.textColor = viewModel.awayScoreColor
        homeTeam.textColor = viewModel.homeTeamNameColor
        awayTeam.textColor = viewModel.awayTeamNameColor
        startTimestamp.textColor = viewModel.startTimeColor
        status.textColor = viewModel.statusColor
        
        if let urlString = viewModel.homeTeamLogoUrl, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { self.homeTeamLogo.image = image }
            }.resume()
        }
        
        if let urlString = viewModel.awayTeamLogoUrl, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { self.awayTeamLogo.image = image }
            }.resume()
        }
        
    }
    
    
    private func setupUI() {
        
        addSubview(startTimestamp)
        addSubview(status)
        addSubview(divider)
        addSubview(homeTeamLogo)
        addSubview(homeTeam)
        addSubview(awayTeamLogo)
        addSubview(awayTeam)
        addSubview(homeScore)
        addSubview(awayScore)
        
        homeTeam.numberOfLines = 1
        homeTeam.font = AppFont.regular(size: 16)
        homeTeamLogo.snp.makeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.centerY.equalTo(homeTeam)
            make.size.equalTo(16)
            
        }
        homeTeam.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamLogo.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(4)
        }
        
        awayTeam.numberOfLines = 1
        awayTeam.font = AppFont.regular(size: 16)
        awayTeam.snp.makeConstraints { make in
            make.top.equalTo(homeTeam.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(4)
        }
        awayTeamLogo.snp.makeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.centerY.equalTo(awayTeam)
            make.size.equalTo(16)
        }
        awayTeam.snp.makeConstraints { make in
            make.leading.equalTo(awayTeamLogo.snp.trailing).offset(8)
        }
        
        startTimestamp.textAlignment = .center
        startTimestamp.font = AppFont.micro(size: 14)
        startTimestamp.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalToSuperview()
            make.width.equalTo(56)
            make.centerY.equalTo(homeTeam)
        }
        
        status.textAlignment = .center
        status.font = AppFont.micro(size: 14)
        status.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalToSuperview()
            make.width.equalTo(56)
            make.centerY.equalTo(awayTeam)
        }
        
        divider.backgroundColor = .gray
        divider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.leading.equalTo(startTimestamp.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        homeScore.font = AppFont.regular(size: 16)
        homeScore.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(homeTeam)
        }
        
        awayScore.font = AppFont.regular(size: 16)
        awayScore.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(awayTeam)
        }
    }
    
}
