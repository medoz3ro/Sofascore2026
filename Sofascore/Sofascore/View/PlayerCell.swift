import SnapKit
import SofaAcademic
import UIKit

class PlayerCell: UICollectionViewCell, BaseViewProtocol {
    private let playerView = PlayerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func addViews() {
        contentView.addSubview(playerView)
    }

    func styleViews() {
        contentView.backgroundColor = .systemBackground
    }

    func setupConstraints() {
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupGestureRecognizers() {}

    func configure(with viewModel: PlayerViewModel) {
        playerView.configure(with: viewModel)
    }
}
