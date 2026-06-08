import SnapKit
import SofaAcademic
import UIKit

class BasketballIncidentView: BaseView {
    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let divider = UIView()
    private let timeUnderline = UIView()

    override func addViews() {
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(timeUnderline)
        addSubview(divider)
    }

    override func styleViews() {
        backgroundColor = .systemBackground
        iconImageView.contentMode = .scaleAspectFit

        minuteLabel.font = .regular(size: 12)
        minuteLabel.textColor = .onSurface2
        minuteLabel.textAlignment = .center

        timeUnderline.backgroundColor = .onSurface4
        divider.backgroundColor = .onSurface4
    }

    func configure(with viewModel: IncidentViewModel) {
        minuteLabel.text = viewModel.minute
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
            make.top.equalToSuperview().inset(8)
            make.size.equalTo(24)
        }

        divider.snp.remakeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(1)
        }

        minuteLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
        }

        timeUnderline.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(1)
        }
    }

    private func setupAwayLayout() {
        iconImageView.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
            make.size.equalTo(24)
        }

        divider.snp.remakeConstraints { make in
            make.trailing.equalTo(iconImageView.snp.leading).offset(-15)
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview().inset(8)
        }

        minuteLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
        }

        timeUnderline.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(1)
        }
    }
}
