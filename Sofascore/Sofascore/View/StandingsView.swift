import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class StandingsView: BaseView {
    private let positionLabel = UILabel()
    private let logoImageView = UIImageView()
    private let teamNameLabel = UILabel()
    private let colStackView = UIStackView()
    private var columnLabels: [UILabel] = []

    override func addViews() {
        addSubview(positionLabel)
        addSubview(logoImageView)
        addSubview(teamNameLabel)
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

        logoImageView.contentMode = .scaleAspectFit

        teamNameLabel.font = .regular(size: 14)
        teamNameLabel.textColor = .onSurface1
        teamNameLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        positionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
        }

        logoImageView.snp.makeConstraints { make in
            make.leading.equalTo(positionLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        colStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }

        teamNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).offset(8)
            make.trailing.equalTo(colStackView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }

    func configure(
        with viewModel: StandingsViewModel,
        columns: [StandingsColumn]
    ) {
        positionLabel.text = viewModel.position
        teamNameLabel.text = viewModel.teamName
        logoImageView.kf.setImage(
            with: URL(string: viewModel.teamLogoUrl ?? "")
        )

        columnLabels.forEach { $0.removeFromSuperview() }
        columnLabels = []

        zip(columns, viewModel.columns).forEach { column, value in
            let label = UILabel()
            label.text = value
            label.font = .regular(size: 14)
            label.textColor = .onSurface1
            label.textAlignment = .center
            colStackView.addArrangedSubview(label)
            label.snp.makeConstraints { make in make.width.equalTo(column.width)
            }
            columnLabels.append(label)
        }
    }
}
