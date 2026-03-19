import SnapKit
import SofaAcademic
import UIKit

class StatusBarView: BaseView {
    private let logoImageView = UIImageView()
    private let trophyImageView = UIImageView()
    private let settingsImageView = UIImageView()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(trophyImageView)
        addSubview(settingsImageView)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault
        logoImageView.image = UIImage(resource: .sofascoreLockup)
        logoImageView.contentMode = .scaleAspectFit

        trophyImageView.image = UIImage(resource: .trophyIcon)
        trophyImageView.contentMode = .scaleAspectFit

        settingsImageView.image = UIImage(resource: .settingsIcon)
        settingsImageView.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(14)
            make.height.equalTo(20)
            make.width.equalTo(132)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        settingsImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        trophyImageView.snp.makeConstraints { make in
            make.trailing.equalTo(settingsImageView.snp.leading).offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}
