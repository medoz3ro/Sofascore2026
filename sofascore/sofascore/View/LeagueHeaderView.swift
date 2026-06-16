import SnapKit
import SofaAcademic
import UIKit

class LeagueHeaderView: UICollectionReusableView, BaseViewProtocol {
    private let leagueView = LeagueView()
    var onTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
        styleViews()
        setupGestureRecognizers()
    }

    required init?(coder: NSCoder) { fatalError() }

    func addViews() {
        addSubview(leagueView)
    }

    func styleViews() {
        leagueView.backgroundColor = .systemBackground
    }

    func setupConstraints() {
        leagueView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        addGestureRecognizer(tap)
    }

    func configure(with viewModel: LeagueViewModel) {
        leagueView.configure(with: viewModel)
    }

    @objc private func handleTap() {
        onTapped?()
    }
}
