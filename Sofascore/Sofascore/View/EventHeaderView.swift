import SnapKit
import SofaAcademic
import UIKit

class EventHeaderView: BaseView {
    private var viewModel: EventHeaderViewModel?
    private let backButton = UIButton(type: .system)
    private let leagueLogoImageView = UIImageView()
    private let leagueNameLabel = UILabel()

    override func addViews() {
        addSubview(backButton)
        addSubview(leagueLogoImageView)
        addSubview(leagueNameLabel)
    }

    override func styleViews() {
        backButton.setImage(UIImage(named: "arrow_back_icon"), for: .normal)
        backButton.tintColor = .onSurfaceLv1

        leagueLogoImageView.contentMode = .scaleAspectFit

        leagueNameLabel.font = .micro(size: 12)
        leagueNameLabel.textColor = .onSurfaceLv2
        leagueNameLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.size.equalTo(24)
        }

        leagueLogoImageView.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(24)
            make.top.bottom.equalToSuperview().inset(16)
            make.size.equalTo(16)
        }

        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueLogoImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.height.equalTo(16)
        }
    }

    override func setupGestureRecognizers() {
        backButton.addTarget(
            self,
            action: #selector(backTapped),
            for: .touchUpInside
        )
    }

    func configure(with viewModel: EventHeaderViewModel) {
        self.viewModel = viewModel
        leagueNameLabel.text = viewModel.leagueName
        leagueLogoImageView.image = viewModel.leagueLogo
    }

    @objc private func backTapped() {
        viewModel?.backTapHandler()
    }
}
