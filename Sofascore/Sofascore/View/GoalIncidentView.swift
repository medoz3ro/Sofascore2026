import SnapKit
import SofaAcademic
import UIKit

class GoalIncidentView: BaseView {
    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let divider = UIView()
    private let scoreLabel = UILabel()
    private let playerNameLabel = UILabel()

    override func addViews() {
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(divider)
        addSubview(scoreLabel)
        addSubview(playerNameLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .success

        minuteLabel.font = .regular(size: 12)
        minuteLabel.textColor = .onSurface2
        minuteLabel.textAlignment = .center

        divider.backgroundColor = .onSurface4

        scoreLabel.font = .bold(size: 20)
        scoreLabel.textColor = .onSurface1

        playerNameLabel.font = .regular(size: 14)
        playerNameLabel.textColor = .onSurface1
        playerNameLabel.numberOfLines = 2
    }

    func configure(with viewModel: IncidentViewModel) {
        minuteLabel.text = viewModel.minute
        scoreLabel.text = viewModel.score
        playerNameLabel.text = viewModel.playerName
        iconImageView.image = viewModel.icon

        if viewModel.isHomeTeam {
            setupHomeLayout()
        } else {
            setupAwayLayout()
        }
    }

    private func setupHomeLayout() {
        iconImageView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(10)
            make.size.equalTo(24)
        }

        minuteLabel.snp.remakeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(2)
            make.centerX.equalTo(iconImageView)
            make.height.equalTo(14)
        }

        divider.snp.remakeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(1)
        }

        scoreLabel.snp.remakeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(84)
            make.height.equalTo(24)
        }

        playerNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        scoreLabel.textAlignment = .center
        playerNameLabel.textAlignment = .left
    }

    private func setupAwayLayout() {
        iconImageView.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(10)
            make.size.equalTo(24)
        }

        minuteLabel.snp.remakeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(2)
            make.centerX.equalTo(iconImageView)
            make.height.equalTo(14)
        }

        divider.snp.remakeConstraints { make in
            make.trailing.equalTo(iconImageView.snp.leading).offset(-15)
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(1)
        }

        scoreLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(divider.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(84)
            make.height.equalTo(24)
        }

        playerNameLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(scoreLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        scoreLabel.textAlignment = .center
        playerNameLabel.textAlignment = .right
    }
}
