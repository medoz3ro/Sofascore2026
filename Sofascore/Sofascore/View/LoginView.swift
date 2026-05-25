import SnapKit
import SofaAcademic
import UIKit

class LoginView: BaseView {
    var onLoginTapped: ((String, String) -> Void)?

    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let errorLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(usernameField)
        addSubview(passwordField)
        addSubview(loginButton)
        addSubview(errorLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        logoImageView.image = UIImage(resource: .sofascoreLockup)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.tintColor = .primaryDefault

        titleLabel.text = .login
        titleLabel.font = .bold(size: 24)
        titleLabel.textColor = .onSurface1
        titleLabel.textAlignment = .center

        styleTextField(usernameField, placeholder: .usernamePlaceholder)
        styleTextField(passwordField, placeholder: .passwordPlaceholder)
        passwordField.isSecureTextEntry = true

        loginButton.setTitle(.loginButton, for: .normal)
        loginButton.titleLabel?.font = .bold(size: 16)
        loginButton.backgroundColor = .primaryDefault
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8

        errorLabel.font = .regular(size: 12)
        errorLabel.textColor = .liveRed
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(72)
            make.width.equalTo(180)
            make.height.equalTo(28)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(48)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(32)
        }

        usernameField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }

        passwordField.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
    }

    override func setupGestureRecognizers() {
        loginButton.addTarget(
            self,
            action: #selector(loginTapped),
            for: .touchUpInside
        )
    }

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    func hideError() {
        errorLabel.isHidden = true
    }

    @objc private func loginTapped() {
        onLoginTapped?(usernameField.text ?? "", passwordField.text ?? "")
    }

    private func styleTextField(_ field: UITextField, placeholder: String) {
        field.placeholder = placeholder
        field.font = .regular(size: 14)
        field.textColor = .onSurface1
        field.borderStyle = .none
        field.backgroundColor = .systemBackground
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.onSurface4.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
    }
}
