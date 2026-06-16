import SnapKit
import SofaAcademic
import UIKit

class StandingsHeaderView: BaseView {
    private let positionLabel = UILabel()
    private let teamLabel = UILabel()
    private let colStackView = UIStackView()
    private var columnLabels: [UILabel] = []

    override func addViews() {
        addSubview(positionLabel)
        addSubview(teamLabel)
        addSubview(colStackView)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        colStackView.axis = .horizontal
        colStackView.distribution = .fill
        colStackView.spacing = 8

        positionLabel.font = .regular(size: 14)
        positionLabel.textColor = .onSurface2
        positionLabel.textAlignment = .center

        teamLabel.font = .regular(size: 14)
        teamLabel.textColor = .onSurface2
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
        }

        teamLabel.snp.makeConstraints { make in
            make.leading.equalTo(positionLabel.snp.trailing).offset(8)
            make.trailing.equalTo(colStackView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }

    func configure(with viewModel: StandingsHeaderViewModel) {
        positionLabel.text = .standingsPosition
        teamLabel.text = .standingsTeam

        columnLabels.forEach { $0.removeFromSuperview() }
        columnLabels = []

        viewModel.columns.forEach { column in
            let label = UILabel()
            label.text = column.title
            label.font = .regular(size: 14)
            label.textColor = .onSurface2
            label.textAlignment = .center
            colStackView.addArrangedSubview(label)
            label.snp.makeConstraints { make in make.width.equalTo(column.width)
            }
            columnLabels.append(label)
        }
    }
}
