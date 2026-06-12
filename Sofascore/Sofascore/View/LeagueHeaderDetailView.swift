import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class LeagueHeaderDetailView: BaseView {
    private let backButton = UIButton(type: .system)
    private let logoContainerView = UIView()
    private let logoImageView = UIImageView()
    private let leagueNameLabel = UILabel()
    private let countryFlagImageView = UIImageView()
    private let countryNameLabel = UILabel()

    var onBackTapped: (() -> Void)?

    override func addViews() {
        addSubview(backButton)
        addSubview(logoContainerView)
        logoContainerView.addSubview(logoImageView)
        addSubview(leagueNameLabel)
        addSubview(countryFlagImageView)
        addSubview(countryNameLabel)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        backButton.setImage(UIImage(named: "arrow_back_icon"), for: .normal)
        backButton.tintColor = .white

        logoContainerView.backgroundColor = .white
        logoContainerView.layer.cornerRadius = 8

        logoImageView.contentMode = .scaleAspectFit

        leagueNameLabel.font = .bold(size: 20)
        leagueNameLabel.textColor = .white
        leagueNameLabel.numberOfLines = 1

        countryFlagImageView.contentMode = .scaleAspectFit

        countryNameLabel.font = .bold(size: 14)
        countryNameLabel.textColor = .white
        countryNameLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(48)
        }

        logoContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(backButton.snp.bottom)
            make.size.equalTo(56)
            make.bottom.equalToSuperview().inset(16)
        }

        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }

        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoContainerView.snp.trailing).offset(16)
            make.top.equalTo(logoContainerView)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        countryFlagImageView.snp.makeConstraints { make in
            make.leading.equalTo(leagueNameLabel)
            make.top.equalTo(leagueNameLabel.snp.bottom).offset(4)
            make.size.equalTo(16)
        }

        countryNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(countryFlagImageView.snp.trailing).offset(4)
            make.centerY.equalTo(countryFlagImageView)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    override func setupGestureRecognizers() {
        backButton.addTarget(
            self,
            action: #selector(backTapped),
            for: .touchUpInside
        )
    }

    func configure(with viewModel: LeagueHeaderDetailViewModel) {
        leagueNameLabel.text = viewModel.leagueName
        countryNameLabel.text = viewModel.countryName
        logoImageView.kf.setImage(with: URL(string: viewModel.logoUrl ?? ""))
        countryFlagImageView.kf.setImage(
            with: URL(string: viewModel.flagUrl ?? "")
        )
    }

    @objc private func backTapped() {
        onBackTapped?()
    }
}
