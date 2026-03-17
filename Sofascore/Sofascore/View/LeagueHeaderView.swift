import SnapKit
import SofaAcademic
import UIKit

class LeagueHeaderView: UICollectionReusableView {
    private let leagueView = LeagueView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leagueView)
        leagueView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with viewModel: LeagueViewModel) {
        leagueView.configure(with: viewModel)
    }
}
