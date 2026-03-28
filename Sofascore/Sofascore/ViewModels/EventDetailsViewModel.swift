import SofaAcademic
import UIKit

struct EventDetailsViewModel {
    let leagueName: String
    let leagueLogo: UIImage?
    let homeTeamName: String
    let homeTeamLogo: UIImage?
    let awayTeamName: String
    let awayTeamLogo: UIImage?
    let date: String
    let time: String
    let homeScore: Int?
    let awayScore: Int?
    let homeScoreColor: UIColor
    let awayScoreColor: UIColor
    let separatorColor: UIColor
    let statusColor: UIColor
    let statusText: String
    let showScore: Bool
    let showDateTime: Bool

    init(
        event: Event,
        sport: Sport,
        leagueLogo: UIImage?,
        homeTeamLogo: UIImage?,
        awayTeamLogo: UIImage?
    ) {
        let league = event.league
        leagueName = [sport.title, league?.country?.name, league?.name]
            .compactMap { $0 }
            .joined(separator: ", ")
        self.leagueLogo = leagueLogo
        homeTeamName = event.homeTeam.name
        self.homeTeamLogo = homeTeamLogo
        awayTeamName = event.awayTeam.name
        self.awayTeamLogo = awayTeamLogo

        let date = Date(
            timeIntervalSince1970: TimeInterval(event.startTimestamp)
        )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy."
        self.date = dateFormatter.string(from: date)

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        self.time = timeFormatter.string(from: date)

        homeScore = event.homeScore
        awayScore = event.awayScore

        let homeScoreVal = event.homeScore ?? 0
        let awayScoreVal = event.awayScore ?? 0

        switch event.status {
        case .notStarted:
            showScore = false
            showDateTime = true
            homeScoreColor = .onSurfaceLv1
            awayScoreColor = .onSurfaceLv1
            separatorColor = .onSurfaceLv1
            statusColor = .onSurfaceLv2
            statusText = ""
        case .inProgress:
            showScore = true
            showDateTime = false
            homeScoreColor = .liveRed
            awayScoreColor = .liveRed
            separatorColor = .liveRed
            statusColor = .liveRed
            statusText =
                "\(Int((Date().timeIntervalSince1970 - Double(event.startTimestamp)) / 60))'"
        case .halftime:
            showScore = true
            showDateTime = false
            homeScoreColor = .liveRed
            awayScoreColor = .liveRed
            separatorColor = .liveRed
            statusColor = .liveRed
            statusText = .halftime
        case .finished:
            showScore = true
            showDateTime = false
            homeScoreColor =
                homeScoreVal >= awayScoreVal ? .onSurfaceLv1 : .onSurfaceLv2
            awayScoreColor =
                awayScoreVal >= homeScoreVal ? .onSurfaceLv1 : .onSurfaceLv2
            separatorColor = .onSurfaceLv1
            statusColor = .onSurfaceLv2
            statusText = .fullTime
        }
    }

    var homeTeamViewModel: EventTeamViewModel {
        EventTeamViewModel(name: homeTeamName, logo: homeTeamLogo)
    }

    var awayTeamViewModel: EventTeamViewModel {
        EventTeamViewModel(name: awayTeamName, logo: awayTeamLogo)
    }

    var scoreViewModel: EventScoreViewModel? {
        guard showScore else { return nil }
        return EventScoreViewModel(
            homeScore: homeScore.map { "\($0)" } ?? "0",
            awayScore: awayScore.map { "\($0)" } ?? "0",
            homeScoreColor: homeScoreColor,
            awayScoreColor: awayScoreColor,
            separatorColor: separatorColor,
            statusText: statusText,
            statusColor: statusColor
        )
    }
}
