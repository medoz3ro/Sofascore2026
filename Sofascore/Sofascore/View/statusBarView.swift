import SnapKit
import SofaAcademic
import UIKit

class StatusBarView: BaseView {
    private let logoImageView = UIImageView()

    override func addViews() {
        addSubview(logoImageView)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault
        logoImageView.image = UIImage(resource: .sofascoreLockup)
        logoImageView.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(132)
        }
    }
}
