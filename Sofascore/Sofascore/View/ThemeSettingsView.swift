import SnapKit
import SofaAcademic
import UIKit

class ThemeSettingsView: BaseView {
    var onThemeSelected: ((Theme) -> Void)?

    private let titleLabel = UILabel()
    private let bottomDivider = UIView()
    private let lightOptionView = ThemeOptionView()
    private let darkOptionView = ThemeOptionView()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(lightOptionView)
        addSubview(darkOptionView)
        addSubview(bottomDivider)
    }

    override func styleViews() {
        titleLabel.font = .bold(size: 12)
        titleLabel.textColor = .primaryDefault
        titleLabel.text = .theme

        bottomDivider.backgroundColor = .onSurface4

        lightOptionView.onTapped = { [weak self] in self?.selectTheme(.light) }
        darkOptionView.onTapped = { [weak self] in self?.selectTheme(.dark) }
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        lightOptionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        darkOptionView.snp.makeConstraints { make in
            make.top.equalTo(lightOptionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        bottomDivider.snp.makeConstraints { make in
            make.top.equalTo(darkOptionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }

    func configure(with theme: Theme) {
        selectTheme(theme)
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
