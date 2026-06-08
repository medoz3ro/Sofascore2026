import SnapKit
import SofaAcademic
import UIKit

class PeriodCell: UICollectionViewCell, BaseViewProtocol {
    private let periodView = PeriodView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func addViews() {
        contentView.addSubview(periodView)
    }

    func styleViews() {}

    func setupConstraints() {
        periodView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with viewModel: PeriodViewModel) {
        periodView.configure(with: viewModel)
    }
}
