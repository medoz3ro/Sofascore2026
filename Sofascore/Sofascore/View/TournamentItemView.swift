import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class TournamentItemView: BaseView {
    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(nameLabel)
    }

    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit

        nameLabel.font = .regular(size: 12)
        nameLabel.textColor = .onSurface2
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(96)
            make.height.equalTo(32)
            make.bottom.equalToSuperview()
        }
    }

    func configure(with league: League) {
        nameLabel.text = league.name
        logoImageView.kf.setImage(with: URL(string: league.logoUrl ?? ""))
    }
}
