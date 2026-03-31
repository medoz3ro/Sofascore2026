import SnapKit
import SofaAcademic
import UIKit

class EventDetailsView: BaseView {
    private let headerView = EventHeaderView()
    private let homeTeamView = EventTeamView()
    private let awayTeamView = EventTeamView()
    private let scoreView = EventScoreView()
    private let dateTimeView = EventDateTimeView()

    override func addViews() {
        addSubview(headerView)
        addSubview(homeTeamView)
        addSubview(awayTeamView)
        addSubview(scoreView)
        addSubview(dateTimeView)
    }

    override func styleViews() {
        backgroundColor = .systemBackground
    }

    override func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        homeTeamView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        awayTeamView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        scoreView.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamView.snp.trailing)
            make.trailing.equalTo(awayTeamView.snp.leading)
            make.top.equalTo(homeTeamView)
        }

        dateTimeView.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamView.snp.trailing)
            make.trailing.equalTo(awayTeamView.snp.leading)
            make.top.equalTo(headerView.snp.bottom).offset(24)
        }
    }

    func configure(with viewModel: EventDetailsViewModel) {
        headerView.configure(
            with: EventHeaderViewModel(
                leagueName: viewModel.leagueName,
                leagueLogo: viewModel.leagueLogo,
                backTapHandler: viewModel.backTapHandler
            )
        )

        homeTeamView.configure(with: viewModel.homeTeamViewModel)
        awayTeamView.configure(with: viewModel.awayTeamViewModel)

        if let scoreViewModel = viewModel.scoreViewModel {
            scoreView.isHidden = false
            dateTimeView.isHidden = true
            scoreView.configure(with: scoreViewModel)
        } else {
            scoreView.isHidden = true
            dateTimeView.isHidden = false
            dateTimeView.configure(
                with: EventDateTimeViewModel(
                    date: viewModel.date,
                    time: viewModel.time
                )
            )
        }
    }
}
