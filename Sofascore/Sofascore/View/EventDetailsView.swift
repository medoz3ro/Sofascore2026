import SnapKit
import SofaAcademic
import UIKit

class EventDetailsView: BaseView {
    var onBackTapped: (() -> Void)?

    private let headerView = UIView()
    private let backButton = UIButton(type: .system)
    private let leagueLogoImageView = UIImageView()
    private let leagueNameLabel = UILabel()

    private let homeTeamLogoImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let awayTeamLogoImageView = UIImageView()
    private let awayTeamNameLabel = UILabel()

    private let dateLabel = UILabel()
    private let timeLabel = UILabel()

    private let scoreSeparatorLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let statusLabel = UILabel()

    override func addViews() {
        addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(leagueLogoImageView)
        headerView.addSubview(leagueNameLabel)

        addSubview(homeTeamLogoImageView)
        addSubview(homeTeamNameLabel)
        addSubview(awayTeamLogoImageView)
        addSubview(awayTeamNameLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(homeScoreLabel)
        addSubview(scoreSeparatorLabel)
        addSubview(awayScoreLabel)
        addSubview(statusLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        headerView.backgroundColor = .white

        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .onSurfaceLv1
        backButton.addTarget(
            self,
            action: #selector(backTapped),
            for: .touchUpInside
        )

        leagueNameLabel.font = .micro(size: 12)
        leagueNameLabel.textColor = .onSurfaceLv2
        leagueNameLabel.numberOfLines = 1

        homeTeamLogoImageView.contentMode = .scaleAspectFit
        awayTeamLogoImageView.contentMode = .scaleAspectFit

        homeTeamNameLabel.font = .bold(size: 12)
        homeTeamNameLabel.textColor = .onSurfaceLv1
        homeTeamNameLabel.textAlignment = .center
        homeTeamNameLabel.numberOfLines = 2

        awayTeamNameLabel.font = .bold(size: 12)
        awayTeamNameLabel.textColor = .onSurfaceLv1
        awayTeamNameLabel.textAlignment = .center
        awayTeamNameLabel.numberOfLines = 2

        dateLabel.font = .regular(size: 12)
        dateLabel.textColor = .onSurfaceLv1
        dateLabel.textAlignment = .center

        timeLabel.font = .regular(size: 12)
        timeLabel.textColor = .onSurfaceLv1
        timeLabel.textAlignment = .center

        homeScoreLabel.font = .bold(size: 32)
        homeScoreLabel.textAlignment = .center

        awayScoreLabel.font = .bold(size: 32)
        awayScoreLabel.textAlignment = .center

        scoreSeparatorLabel.font = .bold(size: 32)
        scoreSeparatorLabel.textAlignment = .center
        scoreSeparatorLabel.text = "-"

        statusLabel.font = .regular(size: 12)
        statusLabel.textAlignment = .center
    }

    override func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }

        leagueLogoImageView.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }

        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueLogoImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        homeTeamLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(32)
            make.size.equalTo(40)
        }

        homeTeamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(16)
            make.centerX.equalTo(homeTeamLogoImageView)
            make.width.equalTo(96)
            make.height.equalTo(32)
        }

        awayTeamLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(32)
            make.trailing.equalToSuperview().inset(32)
            make.size.equalTo(40)
        }

        awayTeamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(awayTeamLogoImageView.snp.bottom).offset(16)
            make.centerX.equalTo(awayTeamLogoImageView)
            make.width.equalTo(96)
            make.height.equalTo(32)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(homeTeamLogoImageView)
        }

        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
        }

        homeScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(homeTeamLogoImageView)
            make.trailing.equalTo(scoreSeparatorLabel.snp.leading).offset(-8)
        }

        scoreSeparatorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(homeTeamLogoImageView)
        }

        awayScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(homeTeamLogoImageView)
            make.leading.equalTo(scoreSeparatorLabel.snp.trailing).offset(8)
        }

        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreSeparatorLabel.snp.bottom).offset(4)
        }
    }

    func configure(with viewModel: EventDetailsViewModel) {
        leagueNameLabel.text = viewModel.leagueName
        leagueLogoImageView.image = viewModel.leagueLogo
        homeTeamNameLabel.text = viewModel.homeTeamName
        homeTeamLogoImageView.image = viewModel.homeTeamLogo
        awayTeamNameLabel.text = viewModel.awayTeamName
        awayTeamLogoImageView.image = viewModel.awayTeamLogo

        dateLabel.isHidden = !viewModel.showDateTime
        timeLabel.isHidden = !viewModel.showDateTime
        homeScoreLabel.isHidden = !viewModel.showScore
        awayScoreLabel.isHidden = !viewModel.showScore
        scoreSeparatorLabel.isHidden = !viewModel.showScore
        statusLabel.isHidden = !viewModel.showScore

        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        homeScoreLabel.text = viewModel.homeScore.map { "\($0)" } ?? "0"
        awayScoreLabel.text = viewModel.awayScore.map { "\($0)" } ?? "0"
        homeScoreLabel.textColor = viewModel.homeScoreColor
        awayScoreLabel.textColor = viewModel.awayScoreColor
        scoreSeparatorLabel.textColor = viewModel.separatorColor
        statusLabel.textColor = viewModel.statusColor
        statusLabel.text = viewModel.statusText
    }

    @objc private func backTapped() {
        onBackTapped?()
    }
}
