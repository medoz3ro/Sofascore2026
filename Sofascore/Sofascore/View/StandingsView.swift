import SnapKit
import SofaAcademic
import UIKit

class StandingsView: BaseView {
    private let positionContainer = UIView()
    private let positionLabel = UILabel()
    private let teamNameLabel = UILabel()
    private let colStackView = UIStackView()
    private let matchesLabel = UILabel()
    private let winsLabel = UILabel()
    private let drawsLabel = UILabel()
    private let lossesLabel = UILabel()
    private let goalsLabel = UILabel()
    private let pointsLabel = UILabel()

    override func addViews() {
        addSubview(positionContainer)
        positionContainer.addSubview(positionLabel)
        addSubview(teamNameLabel)
        addSubview(colStackView)
        colStackView.addArrangedSubview(matchesLabel)
        colStackView.addArrangedSubview(winsLabel)
        colStackView.addArrangedSubview(drawsLabel)
        colStackView.addArrangedSubview(lossesLabel)
        colStackView.addArrangedSubview(goalsLabel)
        colStackView.addArrangedSubview(pointsLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        colStackView.axis = .horizontal
        colStackView.distribution = .fill
        colStackView.spacing = 8

        positionContainer.backgroundColor = .secondaryDefault
        positionContainer.layer.cornerRadius = 12

        positionLabel.font = .regular(size: 14)
        positionLabel.textColor = .black
        positionLabel.textAlignment = .center

        teamNameLabel.font = .regular(size: 14)
        teamNameLabel.textColor = .onSurface1
        teamNameLabel.numberOfLines = 1

        [matchesLabel, winsLabel, drawsLabel, lossesLabel, goalsLabel, pointsLabel].forEach {
            $0.font = .regular(size: 14)
            $0.textColor = .onSurface1
            $0.textAlignment = .center
        }
    }

    override func setupConstraints() {
        positionContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        positionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        colStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(204)
        }

        teamNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(positionContainer.snp.trailing).offset(8)
            make.trailing.equalTo(colStackView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }

        matchesLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        winsLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        drawsLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        lossesLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        goalsLabel.snp.makeConstraints { make in make.width.equalTo(40) }
        pointsLabel.snp.makeConstraints { make in make.width.equalTo(28) }
    }

    func configure(with viewModel: StandingsViewModel) {
        positionLabel.text = viewModel.position
        teamNameLabel.text = viewModel.teamName
        matchesLabel.text = viewModel.matches
        winsLabel.text = viewModel.wins
        drawsLabel.text = viewModel.draws
        lossesLabel.text = viewModel.losses
        goalsLabel.text = viewModel.goals
        pointsLabel.text = viewModel.points
    }
}
