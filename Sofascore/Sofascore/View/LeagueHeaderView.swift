import SnapKit
import SofaAcademic
import UIKit

class LeagueHeaderView: UICollectionReusableView, BaseViewProtocol {
    private let leagueView = LeagueView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
        styleViews()
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

    func configure(with viewModel: LeagueViewModel) {
        leagueView.configure(with: viewModel)
    }
}
