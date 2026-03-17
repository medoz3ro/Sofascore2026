import SnapKit
import SofaAcademic
import UIKit

class MatchCell: UICollectionViewCell {
    private let matchView = MatchView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(matchView)
        matchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with viewModel: MatchViewModel) {
        matchView.configure(with: viewModel)
    }
}
