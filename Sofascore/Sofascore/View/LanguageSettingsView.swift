import SnapKit
import SofaAcademic
import UIKit

class LanguageSettingsView: BaseView {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let currentLanguageLabel = UILabel()
    private let dropdownButton = UIButton(type: .system)

    var onLanguageSelected: ((String) -> Void)?

    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(currentLanguageLabel)
        containerView.addSubview(dropdownButton)
    }

    override func styleViews() {
        containerView.backgroundColor = .onSurface0
        containerView.layer.cornerRadius = 8

        titleLabel.font = .bold(size: 14)
        titleLabel.textColor = .primaryDefault
        titleLabel.text = .language

        let currentLanguage =
            UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first
            ?? "en"
        currentLanguageLabel.text =
            currentLanguage.hasPrefix("hr") ? String.croatian : String.english
        currentLanguageLabel.font = .regular(size: 14)
        currentLanguageLabel.textColor = .onSurface1

        dropdownButton.setImage(
            UIImage(systemName: "chevron.down"),
            for: .normal
        )
        dropdownButton.tintColor = .onSurface1

        let english = UIAction(title: String.english) { [weak self] _ in
            self?.selectLanguage("en")
        }
        let croatian = UIAction(title: String.croatian) { [weak self] _ in
            self?.selectLanguage("hr")
        }
        dropdownButton.menu = UIMenu(children: [english, croatian])
        dropdownButton.showsMenuAsPrimaryAction = true

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(containerTapped)
        )
        containerView.addGestureRecognizer(tap)
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalToSuperview().inset(16)
        }

        currentLanguageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(6)
        }

        dropdownButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }

    private func selectLanguage(_ code: String) {
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        currentLanguageLabel.text =
            code == "hr" ? String.croatian : String.english
        onLanguageSelected?(code)
    }

    @objc private func containerTapped() {
        dropdownButton.sendActions(for: .touchUpInside)
    }
}
