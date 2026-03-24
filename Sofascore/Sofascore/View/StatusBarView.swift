import SnapKit
import SofaAcademic
import UIKit

class StatusBarView: BaseView {
    private let logoImageView = UIImageView()
    private let trophyImageView = UIImageView()
    private let settingsButton = UIButton(type: .system)
    var onSettingsTapped: (() -> Void)?

    override func addViews() {
        addSubview(logoImageView)
        addSubview(trophyImageView)
        addSubview(settingsButton)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault
        logoImageView.image = UIImage(resource: .sofascoreLockup)
        logoImageView.contentMode = .scaleAspectFit

        trophyImageView.image = UIImage(resource: .trophyIcon)
        trophyImageView.contentMode = .scaleAspectFit

        settingsButton.setImage(UIImage(resource: .settingsIcon), for: .normal)
        settingsButton.tintColor = .white
        settingsButton.addTarget(
            self,
            action: #selector(settingsTapped),
            for: .touchUpInside
        )
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(14)
            make.height.equalTo(20)
            make.width.equalTo(132)
            make.trailing.lessThanOrEqualToSuperview()
        }

        trophyImageView.snp.makeConstraints { make in
            make.trailing.equalTo(settingsButton.snp.leading).offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }

    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
}
