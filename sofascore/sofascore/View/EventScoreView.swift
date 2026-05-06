import SnapKit
import SofaAcademic
import UIKit

class EventScoreView: BaseView {
    private let homeScoreLabel = UILabel()
    private let separatorLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let statusLabel = UILabel()

    override func addViews() {
        addSubview(homeScoreLabel)
        addSubview(separatorLabel)
        addSubview(awayScoreLabel)
        addSubview(statusLabel)
    }

    override func styleViews() {
        homeScoreLabel.font = .bold(size: 32)
        homeScoreLabel.textAlignment = .right

        separatorLabel.font = .bold(size: 32)
        separatorLabel.textAlignment = .center
        separatorLabel.text = "-"

        awayScoreLabel.font = .bold(size: 32)
        awayScoreLabel.textAlignment = .left

        statusLabel.font = .regular(size: 12)
        statusLabel.textAlignment = .center
    }

    override func setupConstraints() {
        separatorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }

        homeScoreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(separatorLabel.snp.leading).offset(-4)
            make.height.equalTo(40)
        }

        awayScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(separatorLabel.snp.trailing).offset(4)
            make.height.equalTo(40)
        }

        statusLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(separatorLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
    }

    func configure(with viewModel: EventScoreViewModel) {
        homeScoreLabel.text = viewModel.homeScore
        awayScoreLabel.text = viewModel.awayScore
        homeScoreLabel.textColor = viewModel.homeScoreColor
        awayScoreLabel.textColor = viewModel.awayScoreColor
        separatorLabel.textColor = viewModel.separatorColor
        statusLabel.text = viewModel.statusText
        statusLabel.textColor = viewModel.statusColor
    }
}
