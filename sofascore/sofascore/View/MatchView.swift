import UIKit
import SnapKit
import SofaAcademic

class MatchView: BaseView{
    private let homeTeamLabel: UILabel = UILabel()
    private let awayTeamLabel: UILabel = UILabel()
    private let statusLabel: UILabel = UILabel()
    private let startTimestampLabel: UILabel = UILabel()
    private let homeScoreLabel: UILabel = UILabel()
    private let awayScoreLabel: UILabel = UILabel()
    private let homeTeamLogo : UIImageView = UIImageView()
    private let awayTeamLogo : UIImageView = UIImageView()
    private let divider: UIView = UIView()
    
    override func addViews() {
        addSubview(startTimestampLabel)
        addSubview(statusLabel)
        addSubview(divider)
        addSubview(homeTeamLogo)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLogo)
        addSubview(awayTeamLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
    }
    
    
    
    override func styleViews() {
        homeTeamLabel.numberOfLines = 1
        homeTeamLabel.font = .regular(size: 14)
        
        awayTeamLabel.numberOfLines = 1
        awayTeamLabel.font = .regular(size: 14)
        
        startTimestampLabel.textAlignment = .center
        startTimestampLabel.font = .micro(size: 12)
        
        statusLabel.textAlignment = .center
        statusLabel.font = .micro(size: 12)
        
        homeScoreLabel.font = .regular(size: 14)
        awayScoreLabel.font = .regular(size: 14)
        
        divider.backgroundColor = .onSurfaceLv2
    }
    
    override func setupConstraints() {
        startTimestampLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalToSuperview().inset(4)
            make.width.equalTo(56)
            make.centerY.equalTo(homeTeamLabel)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalToSuperview().inset(4)
            make.width.equalTo(56)
            make.centerY.equalTo(awayTeamLabel)
        }
        
        divider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(startTimestampLabel.snp.trailing).offset(4)
        }
        
        homeTeamLogo.snp.makeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.centerY.equalTo(homeTeamLabel)
            make.size.equalTo(16)
        }
        
        homeTeamLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamLogo.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(10)
        }
        
        awayTeamLogo.snp.makeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.centerY.equalTo(awayTeamLabel)
            make.size.equalTo(16)
        }
        
        awayTeamLabel.snp.makeConstraints { make in
            make.leading.equalTo(awayTeamLogo.snp.trailing).offset(8)
            make.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(10)
        }
        
        homeScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(homeTeamLabel)
        }
        
        awayScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(awayTeamLabel)
        }
    }
    
    
    
    func configure(with viewModel: MatchViewModel) {
        homeTeamLabel.text = viewModel.homeTeamName
        awayTeamLabel.text = viewModel.awayTeamName
        homeScoreLabel.text = viewModel.homeScore
        awayScoreLabel.text = viewModel.awayScore
        startTimestampLabel.text = viewModel.time
        statusLabel.text = viewModel.status
        homeScoreLabel.textColor = viewModel.homeScoreColor
        awayScoreLabel.textColor = viewModel.awayScoreColor
        homeTeamLabel.textColor = viewModel.homeTeamNameColor
        awayTeamLabel.textColor = viewModel.awayTeamNameColor
        startTimestampLabel.textColor = viewModel.startTimeColor
        statusLabel.textColor = viewModel.statusColor
        homeTeamLogo.image = viewModel.homeTeamLogo
        awayTeamLogo.image = viewModel.awayTeamLogo
    }
}
