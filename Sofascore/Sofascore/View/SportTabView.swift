import SnapKit
import SofaAcademic
import UIKit

class SportTabView: BaseView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let selectionIndicator = UIView()
    private let contentStackView = UIStackView()

    override func addViews() {
        addSubview(contentStackView)
        addSubview(selectionIndicator)
        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(titleLabel)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        contentStackView.spacing = 4

        titleLabel.font = .regular(size: 14)
        titleLabel.textColor = .white

        selectionIndicator.backgroundColor = .white
    }

    override func setupConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(4)
            make.bottom.equalTo(selectionIndicator.snp.top).offset(-4)
        }

        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }

        selectionIndicator.snp.makeConstraints { make in
            make.width.equalTo(102)
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    func configure(with viewModel: SportTabViewModel) {
        iconImageView.image = viewModel.icon
        titleLabel.text = viewModel.title
        selectionIndicator.isHidden = !viewModel.isSelected
    }

    func setSelected(_ isSelected: Bool) {
        selectionIndicator.isHidden = !isSelected
    }
}
