import SnapKit
import SofaAcademic
import UIKit

class EventDetailsView: BaseView {
    var onBackTapped: (() -> Void)?

    private let headerView = UIView()
    private let backButton = UIButton(type: .system)
    private let leagueLogoImageView = UIImageView()
    private let leagueNameLabel = UILabel()

    private let homeTeamView = EventTeamView()
    private let awayTeamView = EventTeamView()
    private let scoreView = EventScoreView()

    private let dateLabel = UILabel()
    private let timeLabel = UILabel()

    override func addViews() {
        addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(leagueLogoImageView)
        headerView.addSubview(leagueNameLabel)

        addSubview(homeTeamView)
        addSubview(awayTeamView)
        addSubview(scoreView)
        addSubview(dateLabel)
        addSubview(timeLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground
        headerView.backgroundColor = .systemBackground

        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .onSurfaceLv1
        backButton.addTarget(
            self,
            action: #selector(backTapped),
            for: .touchUpInside
        )

        leagueLogoImageView.contentMode = .scaleAspectFit

        leagueNameLabel.font = .micro(size: 12)
        leagueNameLabel.textColor = .onSurfaceLv2
        leagueNameLabel.numberOfLines = 1

        dateLabel.font = .regular(size: 12)
        dateLabel.textColor = .onSurfaceLv1
        dateLabel.textAlignment = .center

        timeLabel.font = .regular(size: 12)
        timeLabel.textColor = .onSurfaceLv1
        timeLabel.textAlignment = .center
    }

    override func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.size.equalTo(24)
        }

        leagueLogoImageView.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.size.equalTo(16)
        }

        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueLogoImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        homeTeamView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(44)
            make.height.equalTo(112)
        }

        awayTeamView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(44)
            make.height.equalTo(112)
        }

        scoreView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(homeTeamView)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(homeTeamView.snp.centerY)
        }

        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
    }

    func configure(with viewModel: EventDetailsViewModel) {
        leagueNameLabel.text = viewModel.leagueName
        leagueLogoImageView.image = viewModel.leagueLogo

        homeTeamView.configure(with: viewModel.homeTeamViewModel)
        awayTeamView.configure(with: viewModel.awayTeamViewModel)

        if let scoreViewModel = viewModel.scoreViewModel {
            scoreView.isHidden = false
            dateLabel.isHidden = true
            timeLabel.isHidden = true
            scoreView.configure(with: scoreViewModel)
        } else {
            scoreView.isHidden = true
            dateLabel.isHidden = false
            timeLabel.isHidden = false
            dateLabel.text = viewModel.date
            timeLabel.text = viewModel.time
        }
    }

    @objc private func backTapped() {
        onBackTapped?()
    }
}
