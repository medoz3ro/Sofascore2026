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
    private let themeTitleLabel = UILabel()
    private let themeBottomDivider = UIView()
    private let lightOptionView = ThemeOptionView()
    private let darkOptionView = ThemeOptionView()
    private let databaseTitleLabel = UILabel()
    private let eventCountLabel = UILabel()
    private let leagueCountLabel = UILabel()
    private let databaseDivider = UIView()
    private let accountTitleLabel = UILabel()
    private let userNameLabel = UILabel()
    private let accountDivider = UIView()
    private let logoutButton = UIButton(type: .system)

    override func addViews() {
        addSubview(statusBarView)
        statusBarView.addSubview(backButton)
        statusBarView.addSubview(titleLabel)
        addSubview(themeTitleLabel)
        addSubview(lightOptionView)
        addSubview(darkOptionView)
        addSubview(themeBottomDivider)
        addSubview(databaseTitleLabel)
        addSubview(eventCountLabel)
        addSubview(leagueCountLabel)
        addSubview(databaseDivider)
        addSubview(accountTitleLabel)
        addSubview(userNameLabel)
        addSubview(accountDivider)
        addSubview(logoutButton)
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

        themeTitleLabel.font = .bold(size: 12)
        themeTitleLabel.textColor = .primaryDefault
        themeTitleLabel.text = .theme

        themeBottomDivider.backgroundColor = .onSurface4

        lightOptionView.onTapped = { [weak self] in
            self?.selectTheme(.light)
        }
        darkOptionView.onTapped = { [weak self] in
            self?.selectTheme(.dark)
        }

        databaseTitleLabel.font = .bold(size: 12)
        databaseTitleLabel.textColor = .primaryDefault
        databaseTitleLabel.text = .databaseTitle

        eventCountLabel.font = .regular(size: 14)
        eventCountLabel.textColor = .onSurface1
        eventCountLabel.numberOfLines = 1

        leagueCountLabel.font = .regular(size: 14)
        leagueCountLabel.textColor = .onSurface1
        leagueCountLabel.numberOfLines = 1

        databaseDivider.backgroundColor = .onSurface4

        accountTitleLabel.font = .bold(size: 12)
        accountTitleLabel.textColor = .primaryDefault
        accountTitleLabel.text = .account

        userNameLabel.font = .regular(size: 14)
        userNameLabel.textColor = .onSurface1
        userNameLabel.numberOfLines = 1

        accountDivider.backgroundColor = .onSurface4

        logoutButton.setTitle(.logout, for: .normal)
        logoutButton.titleLabel?.font = .bold(size: 14)
        logoutButton.setTitleColor(.liveRed, for: .normal)
        logoutButton.contentHorizontalAlignment = .left
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

        databaseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(themeBottomDivider.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        eventCountLabel.snp.makeConstraints { make in
            make.top.equalTo(databaseTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        leagueCountLabel.snp.makeConstraints { make in
            make.top.equalTo(eventCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        databaseDivider.snp.makeConstraints { make in
            make.top.equalTo(leagueCountLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }

        accountTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(databaseDivider.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(accountTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        accountDivider.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom)
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
        logoutButton.addTarget(
            self,
            action: #selector(logoutTapped),
            for: .touchUpInside
        )
    }

    func configure(with viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        eventCountLabel.text = viewModel.eventCountText
        leagueCountLabel.text = viewModel.leagueCountText
        userNameLabel.text = viewModel.userName
        selectTheme(viewModel.selectedTheme)
    }

    @objc private func dismissTapped() {
        onDismissTapped?()
    }

    @objc private func logoutTapped() {
        onLogoutTapped?()
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
