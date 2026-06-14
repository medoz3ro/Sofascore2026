import SnapKit
import SofaAcademic
import UIKit

class StandingsHeaderView: BaseView {
    private let positionLabel = UILabel()
    private let teamLabel = UILabel()
    private let colStackView = UIStackView()
    private let col5Label = UILabel()
    private let col1Label = UILabel()
    private let col2Label = UILabel()
    private let col3Label = UILabel()
    private let col4Label = UILabel()
    private let lastLabel = UILabel()

    override func addViews() {
        addSubview(positionLabel)
        addSubview(teamLabel)
        addSubview(colStackView)
        colStackView.addArrangedSubview(col5Label)
        colStackView.addArrangedSubview(col1Label)
        colStackView.addArrangedSubview(col2Label)
        colStackView.addArrangedSubview(col3Label)
        colStackView.addArrangedSubview(col4Label)
        colStackView.addArrangedSubview(lastLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        colStackView.axis = .horizontal
        colStackView.distribution = .fill
        colStackView.spacing = 8

        [positionLabel, teamLabel, col1Label, col2Label, col3Label, col4Label, col5Label, lastLabel].forEach {
            $0.font = .regular(size: 14)
            $0.textColor = .onSurface2
            $0.textAlignment = .center
        }
        positionLabel.textAlignment = .center
        teamLabel.textAlignment = .left
    }

    override func setupConstraints() {
        positionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
        }

        colStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(204)
        }

        teamLabel.snp.makeConstraints { make in
            make.leading.equalTo(positionLabel.snp.trailing).offset(8)
            make.trailing.equalTo(colStackView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }

        col5Label.snp.makeConstraints { make in make.width.equalTo(24) }
        col1Label.snp.makeConstraints { make in make.width.equalTo(24) }
        col2Label.snp.makeConstraints { make in make.width.equalTo(24) }
        col3Label.snp.makeConstraints { make in make.width.equalTo(24) }
        col4Label.snp.makeConstraints { make in make.width.equalTo(40) }
        lastLabel.snp.makeConstraints { make in make.width.equalTo(28) }
    }

    func configure(with viewModel: StandingsHeaderViewModel) {
        positionLabel.text = .standingsPosition
        teamLabel.text = .standingsTeam
        col5Label.text = viewModel.col5
        col1Label.text = viewModel.col1
        col2Label.text = viewModel.col2
        col3Label.text = viewModel.col3
        col4Label.text = viewModel.col4
        lastLabel.text = viewModel.showLastCol ? viewModel.lastCol : ""
    }
}
