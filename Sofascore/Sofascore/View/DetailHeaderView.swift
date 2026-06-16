import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class DetailHeaderView: BaseView {
    private let backButton = UIButton(type: .system)
    private let logoContainerView = UIView()
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let flagImageView = UIImageView()
    private let subtitleLabel = UILabel()

    var onBackTapped: (() -> Void)?

    override func addViews() {
        addSubview(backButton)
        addSubview(logoContainerView)
        logoContainerView.addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(flagImageView)
        addSubview(subtitleLabel)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        backButton.setImage(UIImage(named: "arrow_back_icon"), for: .normal)
        backButton.tintColor = .white

        logoContainerView.backgroundColor = .white
        logoContainerView.layer.cornerRadius = 8

        logoImageView.contentMode = .scaleAspectFit

        titleLabel.font = .bold(size: 20)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1

        flagImageView.contentMode = .scaleAspectFit

        subtitleLabel.font = .bold(size: 14)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
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

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoContainerView.snp.trailing).offset(16)
            make.top.equalTo(logoContainerView)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        flagImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.size.equalTo(16)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(4)
            make.centerY.equalTo(flagImageView)
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

    func configure(with viewModel: DetailHeaderViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        logoImageView.kf.setImage(with: URL(string: viewModel.logoUrl ?? ""))
        flagImageView.kf.setImage(with: URL(string: viewModel.flagUrl ?? ""))

        if viewModel.subtitle.isEmpty {
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(logoContainerView.snp.trailing).offset(16)
                make.centerY.equalTo(logoContainerView)
                make.trailing.equalToSuperview().inset(16)
            }
            subtitleLabel.isHidden = true
            flagImageView.isHidden = true
        } else {
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(logoContainerView.snp.trailing).offset(16)
                make.top.equalTo(logoContainerView)
                make.trailing.equalToSuperview().inset(16)
                make.height.equalTo(24)
            }
            subtitleLabel.isHidden = false
        }
    }

    @objc private func backTapped() {
        onBackTapped?()
    }
}
