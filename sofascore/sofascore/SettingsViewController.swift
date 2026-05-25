import SnapKit
import SofaAcademic
import UIKit

class SettingsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let settingsView = SettingsView()

    private var selectedTheme: Theme {
        get {
            let raw =
                UserDefaults.standard.string(forKey: "selectedTheme") ?? "light"
            return raw == "dark" ? .dark : .light
        }
        set {
            UserDefaults.standard.set(
                newValue == .dark ? "dark" : "light",
                forKey: "selectedTheme"
            )
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(settingsView)
    }

    func styleViews() {
        safeAreaBackgroundView.backgroundColor = .primaryDefault
    }

    func setupConstraints() {
        safeAreaBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        settingsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupBinding() {
        settingsView.onDismissTapped = { [weak self] in
            self?.dismiss(animated: true)
        }

        settingsView.onLogoutTapped = { [weak self] in
            UserSession.shared.clear()
            self?.switchToLogin()
        }
    }

    private func switchToLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak appDelegate] response in
            UserSession.shared.save(response: response)
            appDelegate?.switchToEvents()
        }
        let nav = UINavigationController(rootViewController: loginVC)
        nav.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = nav
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingsView.configure(
            with: SettingsViewModel(
                userName: UserSession.shared.name ?? "",
                selectedTheme: selectedTheme,
                themeTapHandler: { [weak self] theme in
                    self?.selectedTheme = theme
                    self?.applyTheme(theme)
                }
            )
        )
        applyTheme(selectedTheme)
    }

    private func applyTheme(_ theme: Theme) {
        let style: UIUserInterfaceStyle = theme == .light ? .light : .dark
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .forEach { $0.overrideUserInterfaceStyle = style }
    }
}
