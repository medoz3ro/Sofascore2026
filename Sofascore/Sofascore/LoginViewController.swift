import SnapKit
import SofaAcademic
import UIKit

class LoginViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let loginView = LoginView()

    var onLoginSuccess: ((LoginResponse) -> Void)?

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
            self.loginView.hideError()

            let viewModel = LoginViewModel(
                onLoginSuccess: { [weak self] response in
                    self?.onLoginSuccess?(response)
                },
                onLoginFailure: { [weak self] message in
                    self?.loginView.showError(message)
                }
            )
            viewModel.login(username: username, password: password)
        }
    }
}
