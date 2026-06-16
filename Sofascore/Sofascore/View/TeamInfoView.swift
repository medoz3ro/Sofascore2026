import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class TeamInfoView: BaseView {
    private let scrollView = UIScrollView()
    private let mainStackView = UIStackView()

    private let titleLabel = UILabel()

    private let coachContainerView = UIView()
    private let coachImageView = UIImageView()
    private let coachNameLabel = UILabel()
    private let coachFlagImageView = UIImageView()
    private let coachCountryLabel = UILabel()

    private let coachDivider = UIView()

    private let playersStackView = UIStackView()
    private let totalPlayersView = UIView()
    private let foreignPlayersView = UIView()
    private let totalIconImageView = UIImageView()
    private let totalValueLabel = UILabel()
    private let totalTitleLabel = UILabel()
    private let progressView = CircularProgressView()
    private let foreignValueLabel = UILabel()
    private let foreignTitleLabel = UILabel()

    private let playersDivider = UIView()

    private let tournamentsContainerView = UIView()
    private let tournamentsTitleLabel = UILabel()
    private let tournamentsStackView = UIStackView()
    private let tournamentsDivider = UIView()

    private let venueContainerView = UIView()
    private let venueTitleLabel = UILabel()
    private let stadiumLabel = UILabel()
    private let venueNameLabel = UILabel()

    override func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)

        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(coachContainerView)
        mainStackView.addArrangedSubview(coachDivider)
        mainStackView.addArrangedSubview(playersStackView)
        mainStackView.addArrangedSubview(playersDivider)
        mainStackView.addArrangedSubview(tournamentsContainerView)
        mainStackView.addArrangedSubview(venueContainerView)

        coachContainerView.addSubview(coachImageView)
        coachContainerView.addSubview(coachNameLabel)
        coachContainerView.addSubview(coachFlagImageView)
        coachContainerView.addSubview(coachCountryLabel)

        playersStackView.addArrangedSubview(totalPlayersView)
        playersStackView.addArrangedSubview(foreignPlayersView)

        totalPlayersView.addSubview(totalIconImageView)
        totalPlayersView.addSubview(totalValueLabel)
        totalPlayersView.addSubview(totalTitleLabel)

        foreignPlayersView.addSubview(progressView)
        foreignPlayersView.addSubview(foreignValueLabel)
        foreignPlayersView.addSubview(foreignTitleLabel)

        tournamentsContainerView.addSubview(tournamentsTitleLabel)
        tournamentsContainerView.addSubview(tournamentsStackView)
        tournamentsContainerView.addSubview(tournamentsDivider)

        venueContainerView.addSubview(venueTitleLabel)
        venueContainerView.addSubview(stadiumLabel)
        venueContainerView.addSubview(venueNameLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        mainStackView.axis = .vertical
        mainStackView.spacing = 0

        titleLabel.font = .bold(size: 16)
        titleLabel.textColor = .onSurface1
        titleLabel.textAlignment = .center

        coachImageView.contentMode = .scaleAspectFit
        coachImageView.layer.cornerRadius = 20
        coachImageView.clipsToBounds = true

        coachNameLabel.font = .regular(size: 14)
        coachNameLabel.textColor = .onSurface1

        coachFlagImageView.contentMode = .scaleAspectFit

        coachCountryLabel.font = .regular(size: 14)
        coachCountryLabel.textColor = .onSurface2

        coachDivider.backgroundColor = .onSurface4
        playersDivider.backgroundColor = .onSurface4

        playersStackView.axis = .horizontal
        playersStackView.distribution = .fillEqually

        totalIconImageView.image = UIImage(named: "team_icon")
        totalIconImageView.contentMode = .scaleAspectFit
        totalIconImageView.tintColor = .primaryDefault

        totalValueLabel.font = .bold(size: 14)
        totalValueLabel.textColor = .primaryDefault
        totalValueLabel.textAlignment = .center

        totalTitleLabel.font = .regular(size: 12)
        totalTitleLabel.textColor = .onSurface2
        totalTitleLabel.textAlignment = .center
        totalTitleLabel.text = .totalPlayers

        foreignValueLabel.font = .bold(size: 14)
        foreignValueLabel.textColor = .primaryDefault
        foreignValueLabel.textAlignment = .center

        foreignTitleLabel.font = .regular(size: 12)
        foreignTitleLabel.textColor = .onSurface2
        foreignTitleLabel.textAlignment = .center
        foreignTitleLabel.text = .foreignPlayers

        tournamentsDivider.backgroundColor = .onSurface4

        tournamentsTitleLabel.font = .bold(size: 16)
        tournamentsTitleLabel.textColor = .onSurface1
        tournamentsTitleLabel.textAlignment = .center
        tournamentsTitleLabel.text = .tournaments

        tournamentsStackView.axis = .vertical
        tournamentsStackView.spacing = 0

        venueTitleLabel.font = .bold(size: 16)
        venueTitleLabel.textColor = .onSurface1
        venueTitleLabel.textAlignment = .center
        venueTitleLabel.text = .venue

        venueNameLabel.font = .regular(size: 14)
        venueNameLabel.textColor = .onSurface1

        stadiumLabel.font = .regular(size: 14)
        stadiumLabel.textColor = .onSurface1
        stadiumLabel.text = .stadium
    }

    override func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        coachContainerView.snp.makeConstraints { make in
            make.height.equalTo(72)
        }

        coachImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }

        coachNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(coachImageView.snp.trailing).offset(16)
            make.top.equalTo(coachImageView)
            make.trailing.equalToSuperview().inset(16)
        }

        coachFlagImageView.snp.makeConstraints { make in
            make.leading.equalTo(coachNameLabel)
            make.top.equalTo(coachNameLabel.snp.bottom).offset(4)
            make.size.equalTo(16)
        }

        coachCountryLabel.snp.makeConstraints { make in
            make.leading.equalTo(coachFlagImageView.snp.trailing).offset(4)
            make.centerY.equalTo(coachFlagImageView)
        }

        coachDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        totalIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(32)
        }

        totalValueLabel.snp.makeConstraints { make in
            make.top.equalTo(totalIconImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        totalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(totalValueLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.bottom.equalToSuperview().inset(16)
        }

        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(32)
        }

        foreignValueLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        foreignTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(foreignValueLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.bottom.equalToSuperview().inset(16)
        }

        playersDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        tournamentsTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        tournamentsStackView.snp.makeConstraints { make in
            make.top.equalTo(tournamentsTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        tournamentsDivider.snp.makeConstraints { make in
            make.top.equalTo(tournamentsStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }

        venueTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        stadiumLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(venueTitleLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(16)
        }

        venueNameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(stadiumLabel)
        }
    }

    func configure(with viewModel: TeamInfoViewModel) {
        titleLabel.text = .teamInfo
        coachImageView.kf.setImage(
            with: URL(string: viewModel.managerImageUrl ?? "")
        )
        coachNameLabel.text = viewModel.managerName
        coachCountryLabel.text = viewModel.managerCountry
        coachFlagImageView.kf.setImage(
            with: URL(string: viewModel.managerFlagUrl ?? "")
        )
        totalValueLabel.text = viewModel.totalPlayers
        foreignValueLabel.text = viewModel.foreignPlayers
        venueNameLabel.text = viewModel.venueName

        progressView.setProgress(viewModel.foreignPlayersRatio)

        tournamentsStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        let hasTournaments = !viewModel.tournaments.isEmpty
        tournamentsContainerView.isHidden = !hasTournaments

        var rowStack: UIStackView?
        viewModel.tournaments.enumerated().forEach { index, league in
            if index % 3 == 0 {
                rowStack = UIStackView()
                rowStack?.axis = .horizontal
                rowStack?.distribution = .fillEqually
                rowStack?.spacing = 0
                tournamentsStackView.addArrangedSubview(rowStack!)
            }
            let item = TournamentItemView()
            item.configure(with: LeagueViewModel(league: league))
            rowStack?.addArrangedSubview(item)
        }
    }
}
