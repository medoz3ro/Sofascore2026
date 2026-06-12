import SnapKit
import SofaAcademic
import UIKit

class LeagueTabView: BaseView {
    private let titleLabel = UILabel()

    override func styleViews() {
        titleLabel.font = .regular(size: 14)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
    }

    override func addViews() {
        addSubview(titleLabel)
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    func configure(with tab: LeagueTab) {
        switch tab {
        case .matches: titleLabel.text = .matches
        case .standings: titleLabel.text = .standings
        }
    }
}
