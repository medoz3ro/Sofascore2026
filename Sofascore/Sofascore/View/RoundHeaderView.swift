import SnapKit
import SofaAcademic
import UIKit

class RoundHeaderView: UICollectionReusableView, BaseViewProtocol {
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func addViews() {
        addSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = .onSurface0
        titleLabel.font = .bold(size: 12)
        titleLabel.textColor = .onSurface1
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(16)
        }
    }

    func setupGestureRecognizers() {}

    func configure(with title: String) {
        titleLabel.text = title
    }
}
