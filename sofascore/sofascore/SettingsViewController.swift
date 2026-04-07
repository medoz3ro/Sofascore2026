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

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingsView.configure(
            with: SettingsViewModel(
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
