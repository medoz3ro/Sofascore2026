import SnapKit
import SofaAcademic
import UIKit

class AccountView: BaseView {
    var onLogoutTapped: (() -> Void)?

    private let titleLabel = UILabel()
    private let userNameLabel = UILabel()
    private let logoutButton = UIButton(type: .system)
    private let bottomDivider = UIView()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(userNameLabel)
        addSubview(logoutButton)
        addSubview(bottomDivider)
    }

    override func styleViews() {
        titleLabel.font = .bold(size: 12)
        titleLabel.textColor = .primaryDefault
        titleLabel.text = .account

        userNameLabel.font = .regular(size: 14)
        userNameLabel.textColor = .onSurface1
        userNameLabel.numberOfLines = 1

        logoutButton.setTitle(.logout, for: .normal)
        logoutButton.titleLabel?.font = .bold(size: 14)
        logoutButton.setTitleColor(.liveRed, for: .normal)
        logoutButton.contentHorizontalAlignment = .left

        bottomDivider.backgroundColor = .onSurface4
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        bottomDivider.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
        logoutButton.addTarget(
            self,
            action: #selector(logoutTapped),
            for: .touchUpInside
        )
    }

    func configure(userName: String) {
        userNameLabel.text = userName
    }

    @objc private func logoutTapped() {
        onLogoutTapped?()
    }
}
