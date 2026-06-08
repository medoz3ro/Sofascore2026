import SnapKit
import SofaAcademic
import UIKit

class IncidentView: BaseView {
    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let divider = UIView()
    private let playerNameLabel = UILabel()
    private let descriptionLabel = UILabel()

    override func addViews() {
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(divider)
        addSubview(playerNameLabel)
        addSubview(descriptionLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .success

        minuteLabel.font = .regular(size: 12)
        minuteLabel.textColor = .onSurface2
        minuteLabel.textAlignment = .center

        divider.backgroundColor = .onSurface4

        playerNameLabel.font = .regular(size: 14)
        playerNameLabel.textColor = .onSurface1
        playerNameLabel.numberOfLines = 2

        descriptionLabel.font = .regular(size: 12)
        descriptionLabel.textColor = .onSurface2
        descriptionLabel.numberOfLines = 1
    }

    func configure(with viewModel: IncidentViewModel) {
        minuteLabel.text = viewModel.minute
        playerNameLabel.text = viewModel.playerName
        descriptionLabel.text = viewModel.description
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

        playerNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(divider.snp.trailing).offset(12)
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        descriptionLabel.snp.remakeConstraints { make in
            make.leading.equalTo(playerNameLabel)
            make.top.equalTo(playerNameLabel.snp.bottom).offset(2)
            make.trailing.equalTo(playerNameLabel)
            make.height.equalTo(14)
        }

        playerNameLabel.textAlignment = .left
        descriptionLabel.textAlignment = .left
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

        playerNameLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(divider.snp.leading).offset(-12)
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        descriptionLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(playerNameLabel)
            make.top.equalTo(playerNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(playerNameLabel)
            make.height.equalTo(14)
        }

        playerNameLabel.textAlignment = .right
        descriptionLabel.textAlignment = .right
    }
}
