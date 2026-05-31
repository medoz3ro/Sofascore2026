import SnapKit
import SofaAcademic
import UIKit

class LoginViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(loginView)
    }

    func styleViews() {
        view.backgroundColor = .systemBackground
        safeAreaBackgroundView.backgroundColor = .primaryDefault
    }

    func setupConstraints() {
        safeAreaBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        loginView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupBinding() {
        loginView.onLoginTapped = { [weak self] username, password in
            guard let self else { return }
            self.loginView.errorMessage(nil)
            self.login(username: username, password: password)
        }
    }

    private func login(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            loginView.errorMessage(.emptyFieldsError)
            return
        }

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let response = try await APIClient.login(
                    request: LoginRequest(
                        username: username,
                        password: password
                    )
                )
                UserSession.shared.save(response: response)
                (UIApplication.shared.delegate as? AppDelegate)?
                    .switchToEvents()
            } catch {
                self.loginView.errorMessage(.loginError)
            }
        }
    }
}
