import UIKit

struct EventDetailsViewModel {
    struct ScoreColors {
        let homeScoreColor: UIColor
        let awayScoreColor: UIColor
        let separatorColor: UIColor
        let statusColor: UIColor
    }

    let leagueName: String
    let leagueLogo: String?
    let homeTeamName: String
    let homeTeamLogo: String?
    let awayTeamName: String
    let awayTeamLogo: String?
    let date: String
    let time: String
    let homeScore: Int?
    let awayScore: Int?
    let scoreColors: ScoreColors
    let statusText: String
    let showScore: Bool
    let backTapHandler: () -> Void

    init(
        event: Event,
        sport: Sport,
        backTapHandler: @escaping () -> Void
    ) {
        self.backTapHandler = backTapHandler

        let league = event.league
        leagueName = [sport.title, league?.country?.name, league?.name]
            .compactMap { $0 }
            .joined(separator: ", ")
        self.leagueLogo = league?.logoUrl
        homeTeamName = event.homeTeam.name
        self.homeTeamLogo = event.homeTeam.logoUrl
        awayTeamName = event.awayTeam.name
        self.awayTeamLogo = event.awayTeam.logoUrl
        date = Self.formatDate(from: event.startTimestamp)
        time = Self.formatTime(from: event.startTimestamp)
        homeScore = event.homeScore
        awayScore = event.awayScore
        showScore = Self.resolveShowScore(for: event)
        scoreColors = Self.resolveScoreColors(for: event)
        statusText = Self.resolveStatusText(for: event)
    }

    private static func formatDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        return formatter.string(from: date)
    }

    private static func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private static func resolveShowScore(for event: Event) -> Bool {
        switch event.status {
        case .notStarted: return false
        default: return true
        }
    }

    private static func resolveStatusText(for event: Event) -> String {
        switch event.status {
        case .notStarted: return ""
        case .inProgress:
            let elapsed = Int(
                (Date().timeIntervalSince1970 - Double(event.startTimestamp))
                    / 60
            )
            return "\(elapsed)'"
        case .halftime: return .halftime
        case .finished: return .fullTime
        }
    }

    private static func resolveScoreColors(for event: Event) -> ScoreColors {
        let homeScoreVal = event.homeScore ?? 0
        let awayScoreVal = event.awayScore ?? 0
        switch event.status {
        case .notStarted:
            return ScoreColors(
                homeScoreColor: .onSurface1,
                awayScoreColor: .onSurface1,
                separatorColor: .onSurface1,
                statusColor: .onSurface2
            )
        case .inProgress, .halftime:
            return ScoreColors(
                homeScoreColor: .liveRed,
                awayScoreColor: .liveRed,
                separatorColor: .liveRed,
                statusColor: .liveRed
            )
        case .finished:
            return ScoreColors(
                homeScoreColor: homeScoreVal >= awayScoreVal
                    ? .onSurface1 : .onSurface2,
                awayScoreColor: awayScoreVal >= homeScoreVal
                    ? .onSurface1 : .onSurface2,
                separatorColor: .onSurface2,
                statusColor: .onSurface2
            )
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
            homeScoreColor: scoreColors.homeScoreColor,
            awayScoreColor: scoreColors.awayScoreColor,
            separatorColor: scoreColors.separatorColor,
            statusText: statusText,
            statusColor: scoreColors.statusColor
        )
    }
}
