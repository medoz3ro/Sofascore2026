import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class StatView: BaseView {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let flagImageView = UIImageView()
    private let valueLabel = UILabel()

    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(flagImageView)
        containerView.addSubview(valueLabel)
    }

    override func styleViews() {
        containerView.backgroundColor = .secondaryHighlight
        containerView.layer.cornerRadius = 4

        titleLabel.font = .regular(size: 12)
        titleLabel.textColor = .onSurface2
        titleLabel.textAlignment = .center

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .primaryDefault
        iconImageView.isHidden = true

        flagImageView.contentMode = .scaleAspectFit
        flagImageView.isHidden = true

        valueLabel.font = .bold(size: 14)
        valueLabel.textColor = .onSurface1
        valueLabel.numberOfLines = 0
        valueLabel.textAlignment = .center
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(104)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().inset(8)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.size.equalTo(28)
        }

        flagImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.centerY.equalTo(valueLabel)
        }

        valueLabel.snp.makeConstraints { make in
            make.center.equalTo(iconImageView)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }

    func configure(with viewModel: StatViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value

        switch viewModel.type {
        case .text:
            iconImageView.isHidden = true
            flagImageView.isHidden = true
            valueLabel.font = .bold(size: 14)
            valueLabel.textColor = .onSurface1
            valueLabel.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(8)
            }

        case .flag(let url):
            iconImageView.isHidden = true
            flagImageView.isHidden = false
            flagImageView.kf.setImage(with: URL(string: url))
            valueLabel.font = .bold(size: 14)
            valueLabel.textColor = .onSurface1
            valueLabel.snp.remakeConstraints { make in
                make.centerX.equalToSuperview().offset(10)
                make.centerY.equalToSuperview().offset(8)
            }
            flagImageView.snp.remakeConstraints { make in
                make.size.equalTo(16)
                make.centerY.equalTo(valueLabel)
                make.trailing.equalTo(valueLabel.snp.leading).offset(-4)
            }

        case .icon(let image, let color):
            iconImageView.isHidden = false
            iconImageView.image = image
            flagImageView.isHidden = true
            valueLabel.font = .bold(size: 10)
            valueLabel.textColor = color
            iconImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(8)
                make.size.equalTo(28)
            }
            valueLabel.snp.remakeConstraints { make in
                make.center.equalTo(iconImageView)
            }
        }
    }
}
