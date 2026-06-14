import SnapKit
import SofaAcademic
import UIKit

class StandingsCell: UICollectionViewCell, BaseViewProtocol {
    private let standingsView = StandingsView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func addViews() {
        contentView.addSubview(standingsView)
    }

    func styleViews() {
        contentView.backgroundColor = .systemBackground
    }

    func setupConstraints() {
        standingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupGestureRecognizers() {}

    func configure(with viewModel: StandingsViewModel) {
        standingsView.configure(with: viewModel)
    }
}
