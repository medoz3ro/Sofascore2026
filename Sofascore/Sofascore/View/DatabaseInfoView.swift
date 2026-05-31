import SnapKit
import SofaAcademic
import UIKit

class DatabaseInfoView: BaseView {
    private let titleLabel = UILabel()
    private let eventCountLabel = UILabel()
    private let leagueCountLabel = UILabel()
    private let bottomDivider = UIView()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(eventCountLabel)
        addSubview(leagueCountLabel)
        addSubview(bottomDivider)
    }

    override func styleViews() {
        titleLabel.font = .bold(size: 12)
        titleLabel.textColor = .primaryDefault
        titleLabel.text = .databaseTitle

        eventCountLabel.font = .regular(size: 14)
        eventCountLabel.textColor = .onSurface1
        eventCountLabel.numberOfLines = 1

        leagueCountLabel.font = .regular(size: 14)
        leagueCountLabel.textColor = .onSurface1
        leagueCountLabel.numberOfLines = 1

        bottomDivider.backgroundColor = .onSurface4
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }

        eventCountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        leagueCountLabel.snp.makeConstraints { make in
            make.top.equalTo(eventCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        bottomDivider.snp.makeConstraints { make in
            make.top.equalTo(leagueCountLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }

    func configure(eventCountText: String, leagueCountText: String) {
        eventCountLabel.text = eventCountText
        leagueCountLabel.text = leagueCountText
    }
}
