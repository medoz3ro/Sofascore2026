import SofaAcademic
import UIKit

struct TeamViewModel {
    let name: String
    let logo: UIImage?
    let score: String
    let colors: TeamColors
}

struct TeamColors {
    let nameColor: UIColor
    let scoreColor: UIColor
}

struct MatchViewModel {
    let homeTeamViewModel: TeamViewModel
    let awayTeamViewModel: TeamViewModel
    let time: String
    let status: String
    let startTimeColor: UIColor
    let statusColor: UIColor
    let matchTapHandler: (() -> Void)?

    init(
        event: Event,
        homeTeamLogo: UIImage?,
        awayTeamLogo: UIImage?,
        matchTapHandler: (() -> Void)? = nil
    ) {
        self.matchTapHandler = matchTapHandler
        time = Self.formatTime(from: event.startTimestamp)
        status = Self.formatStatus(for: event)

        self.statusColor = Self.resolveStatusColor(for: event)
        self.startTimeColor = .onSurfaceLv2
        let colors = Self.resolveTeamColors(for: event)

        homeTeamViewModel = TeamViewModel(
            name: event.homeTeam.name,
            logo: homeTeamLogo,
            score: event.homeScore.map { "\($0)" } ?? "",
            colors: colors.home
        )

        awayTeamViewModel = TeamViewModel(
            name: event.awayTeam.name,
            logo: awayTeamLogo,
            score: event.awayScore.map { "\($0)" } ?? "",
            colors: colors.away
        )
    }

    private static func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private static func formatStatus(for event: Event) -> String {
        switch event.status {
        case .notStarted: return .notStarted
        case .inProgress:
            let elapsed = Int(
                (Date().timeIntervalSince1970 - Double(event.startTimestamp))
                    / 60
            )
            return "\(elapsed)'"
        case .halftime: return .halftime
        case .finished: return .finished
        }
    }

    private static func resolveStatusColor(for event: Event) -> UIColor {
        switch event.status {
        case .inProgress: return .liveRed
        default: return .onSurfaceLv2
        }
    }

    private static func resolveTeamColors(for event: Event) -> (
        home: TeamColors, away: TeamColors
    ) {
        switch event.status {
        case .inProgress:
            return (
                home: TeamColors(
                    nameColor: .onSurfaceLv1,
                    scoreColor: .liveRed
                ),
                away: TeamColors(nameColor: .onSurfaceLv1, scoreColor: .liveRed)
            )
        case .finished:
            if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                return (
                    home: TeamColors(
                        nameColor: .onSurfaceLv2,
                        scoreColor: .onSurfaceLv2
                    ),
                    away: TeamColors(
                        nameColor: .onSurfaceLv1,
                        scoreColor: .onSurfaceLv1
                    )
                )
            } else if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                return (
                    home: TeamColors(
                        nameColor: .onSurfaceLv1,
                        scoreColor: .onSurfaceLv1
                    ),
                    away: TeamColors(
                        nameColor: .onSurfaceLv2,
                        scoreColor: .onSurfaceLv2
                    )
                )
            } else {
                return (
                    home: TeamColors(
                        nameColor: .onSurfaceLv1,
                        scoreColor: .onSurfaceLv1
                    ),
                    away: TeamColors(
                        nameColor: .onSurfaceLv1,
                        scoreColor: .onSurfaceLv1
                    )
                )
            }
        default:
            return (
                home: TeamColors(
                    nameColor: .onSurfaceLv1,
                    scoreColor: .onSurfaceLv1
                ),
                away: TeamColors(
                    nameColor: .onSurfaceLv1,
                    scoreColor: .onSurfaceLv1
                )
            )
        }
    }
}
