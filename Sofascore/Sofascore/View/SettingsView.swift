import SnapKit
import SofaAcademic
import UIKit

class SettingsView: BaseView {
    var onDismissTapped: (() -> Void)?
    
    private var viewModel: SettingsViewModel?
    private let statusBarView = UIView()
    private let titleLabel = UILabel()
    private let backButton = UIButton(type: .system)
    private let themeTitleLabel = UILabel()
    private let themeBottomDivider = UIView()
    private let lightOptionView = ThemeOptionView()
    private let darkOptionView = ThemeOptionView()

    override func addViews() {
        addSubview(statusBarView)
        statusBarView.addSubview(backButton)
        statusBarView.addSubview(titleLabel)
        addSubview(themeTitleLabel)
        addSubview(lightOptionView)
        addSubview(darkOptionView)
        addSubview(themeBottomDivider)
    }

    override func styleViews() {
        backgroundColor = .systemBackground
        statusBarView.backgroundColor = .primaryDefault

        titleLabel.font = .bold(size: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = .settings

        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .white

        themeTitleLabel.font = .bold(size: 12)
        themeTitleLabel.textColor = .primaryDefault
        themeTitleLabel.text = .theme

        themeBottomDivider.backgroundColor = .onSurfaceLv4

        lightOptionView.onTapped = { [weak self] in
            self?.selectTheme(.light)
        }
        darkOptionView.onTapped = { [weak self] in
            self?.selectTheme(.dark)
        }
    }

    override func setupConstraints() {
        statusBarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(32)
            make.centerY.equalTo(statusBarView)
            make.height.equalTo(28)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalTo(statusBarView).inset(12)
            make.size.equalTo(24)
        }

        themeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        lightOptionView.snp.makeConstraints { make in
            make.top.equalTo(themeTitleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        darkOptionView.snp.makeConstraints { make in
            make.top.equalTo(lightOptionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        themeBottomDivider.snp.makeConstraints { make in
            make.top.equalTo(darkOptionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    override func setupGestureRecognizers() {
        backButton.addTarget(
            self,
            action: #selector(dismissTapped),
            for: .touchUpInside
        )
    }

    func configure(with viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        selectTheme(viewModel.selectedTheme)
    }

    @objc private func dismissTapped() {
        onDismissTapped?()
    }

    private func selectTheme(_ theme: Theme) {
        lightOptionView.configure(
            with: ThemeOptionViewModel(
                title: .light,
                isSelected: theme == .light
            )
        )
        darkOptionView.configure(
            with: ThemeOptionViewModel(title: .dark, isSelected: theme == .dark)
        )
        viewModel?.themeTapHandler(theme)
    }
}
