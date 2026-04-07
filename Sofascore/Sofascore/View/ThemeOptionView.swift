import SnapKit
import SofaAcademic
import UIKit

class ThemeOptionView: BaseView {
    var onTapped: (() -> Void)?

    private let titleLabel = UILabel()
    private let radioButton = UIButton(type: .system)

    override func addViews() {
        addSubview(titleLabel)
        addSubview(radioButton)
    }

    override func styleViews() {
        titleLabel.font = .regular(size: 14)
        titleLabel.textColor = .onSurfaceLv1

        radioButton.isUserInteractionEnabled = false
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
        }

        radioButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
    }

    func configure(with viewModel: ThemeOptionViewModel) {
        titleLabel.text = viewModel.title
        let image =
            viewModel.isSelected
            ? UIImage(systemName: "record.circle")
            : UIImage(systemName: "circle")
        radioButton.setImage(image, for: .normal)
        radioButton.tintColor =
            viewModel.isSelected ? .primaryDefault : .onSurfaceLv2
    }

    override func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapped)
        )
        addGestureRecognizer(tap)
    }

    @objc private func tapped() {
        onTapped?()
    }
}
