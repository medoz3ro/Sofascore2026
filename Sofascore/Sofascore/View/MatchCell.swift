import SnapKit
import SofaAcademic
import UIKit

class MatchCell: UICollectionViewCell, BaseViewProtocol {
    private let matchView = MatchView()
    var onTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
        setupGestureRecognizers()
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

    func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(cellTapped)
        )
        addGestureRecognizer(tap)
    }

    @objc private func cellTapped() {
        onTapped?()
    }
}
