import SnapKit
import SofaAcademic
import UIKit

class MatchCell: UICollectionViewCell, BaseViewProtocol {
    private let matchView = MatchView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) { fatalError() }

    func addViews() {
        contentView.addSubview(matchView)
    }

    func setupConstraints() {
        matchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with viewModel: MatchViewModel) {
        matchView.configure(with: viewModel)
    }
}
