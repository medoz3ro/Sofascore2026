import SnapKit
import SofaAcademic
import UIKit

class SettingsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let settingsView = SettingsView()
    private var selectedTheme: Theme = .light
    var onThemeChanged: ((Theme) -> Void)?

    init(selectedTheme: Theme) {
        self.selectedTheme = selectedTheme
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
        settingsView.configure(
            with: SettingsViewModel(
                title: "Settings",
                selectedTheme: selectedTheme
            )
        )

        settingsView.onThemeSelected = { [weak self] theme in
            self?.selectedTheme = theme
            let style: UIUserInterfaceStyle = theme == .light ? .light : .dark
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .forEach { $0.overrideUserInterfaceStyle = style }
            self?.onThemeChanged?(theme)
        }

        settingsView.onDismissTapped = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
