import SnapKit
import SofaAcademic
import UIKit

class SportTabView: BaseView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let contentStackView = UIStackView()

    override func addViews() {
        addSubview(contentStackView)
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
    }

    override func setupConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(8)
        }

        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
    }

    func configure(with viewModel: SportTabViewModel) {
        iconImageView.image = viewModel.image
        titleLabel.text = viewModel.title
    }
}
