import SnapKit
import SofaAcademic
import UIKit

class SettingsView: BaseView {
    var onDismissTapped: (() -> Void)?
    var onLogoutTapped: (() -> Void)?

    private var viewModel: SettingsViewModel?
    private let statusBarView = UIView()
    private let titleLabel = UILabel()
    private let backButton = UIButton(type: .custom)
    private let themeSettingsView = ThemeSettingsView()
    private let databaseInfoView = DatabaseInfoView()
    private let accountView = AccountView()

    override func addViews() {
        addSubview(statusBarView)
        statusBarView.addSubview(backButton)
        statusBarView.addSubview(titleLabel)
        addSubview(themeSettingsView)
        addSubview(databaseInfoView)
        addSubview(accountView)
    }

    override func styleViews() {
        backgroundColor = .systemBackground
        statusBarView.backgroundColor = .primaryDefault

        titleLabel.font = .bold(size: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = .settings

        backButton.setImage(UIImage(named: "arrow_back_icon"), for: .normal)
        backButton.tintColor = .white

        themeSettingsView.onThemeSelected = { [weak self] theme in
            self?.viewModel?.themeTapHandler(theme)
        }

        accountView.onLogoutTapped = { [weak self] in
            self?.onLogoutTapped?()
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

        themeSettingsView.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        databaseInfoView.snp.makeConstraints { make in
            make.top.equalTo(themeSettingsView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        accountView.snp.makeConstraints { make in
            make.top.equalTo(databaseInfoView.snp.bottom)
            make.leading.trailing.equalToSuperview()
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
        themeSettingsView.configure(with: viewModel.selectedTheme)
        databaseInfoView.configure(
            eventCountText: viewModel.eventCountText,
            leagueCountText: viewModel.leagueCountText
        )
        accountView.configure(userName: viewModel.userName)
    }

    @objc private func dismissTapped() {
        onDismissTapped?()
    }
}
