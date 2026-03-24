import SnapKit
import SofaAcademic
import UIKit

class SettingsView: BaseView {
    var onThemeSelected: ((Theme) -> Void)?
    var onDismissTapped: (() -> Void)?

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

        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(
            self,
            action: #selector(dismissTapped),
            for: .touchUpInside
        )

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
            make.height.equalTo(48)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(20)
            make.centerY.equalTo(statusBarView)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalTo(statusBarView)
            make.size.equalTo(24)
        }

        themeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        lightOptionView.snp.makeConstraints { make in
            make.top.equalTo(themeTitleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }

        darkOptionView.snp.makeConstraints { make in
            make.top.equalTo(lightOptionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }

        themeBottomDivider.snp.makeConstraints { make in
            make.top.equalTo(darkOptionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    func configure(with viewModel: SettingsViewModel) {
        titleLabel.text = viewModel.title
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
        onThemeSelected?(theme)
    }
}
