import SnapKit
import SofaAcademic
import UIKit

struct MatchViewModel {
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamNameColor: UIColor
    let awayTeamNameColor: UIColor
    let homeTeamLogo: UIImage?
    let awayTeamLogo: UIImage?
    let homeScore: String?
    let awayScore: String?
    let homeScoreColor: UIColor
    let awayScoreColor: UIColor
    let time: String
    let status: String
    let scoreColor: UIColor
    let startTimeColor: UIColor
    let statusColor: UIColor
    
    init(event: Event, homeTeamLogo: UIImage?, awayTeamLogo: UIImage?) {
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamLogo = awayTeamLogo
        homeTeamName = event.homeTeam.name
        awayTeamName = event.awayTeam.name
        homeScore = event.homeScore.map { "\($0)" }
        awayScore = event.awayScore.map { "\($0)" }
        
        time = Self.formatTime(from: event.startTimestamp)
        status = Self.formatStatus(for: event)
        
        let colors = Self.resolveTeamColors(for: event)
        homeTeamNameColor = colors.homeTeamNameColor
        awayTeamNameColor = colors.awayTeamNameColor
        homeScoreColor = colors.homeScoreColor
        awayScoreColor = colors.awayScoreColor
        
        let statusColor = Self.resolveStatusColor(for: event)
        self.statusColor = statusColor
        self.startTimeColor = statusColor
        self.scoreColor = statusColor
    }
    
    private static func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private static func formatStatus(for event: Event) -> String {
        switch event.status {
        case .notStarted: return "-"
        case .inProgress:
            let elapsed = Int((Date().timeIntervalSince1970 - Double(event.startTimestamp)) / 60)
            return "\(elapsed)'"
        case .halftime: return "HT"
        case .finished: return "FT"
        }
    }
    
    private static func resolveStatusColor(for event: Event) -> UIColor {
        switch event.status {
        case .inProgress: return .liveRed
        default: return .onSurfaceLv2
        }
    }
    
    private static func resolveTeamColors(for event: Event) -> (homeTeamNameColor: UIColor, awayTeamNameColor: UIColor, homeScoreColor: UIColor, awayScoreColor: UIColor) {
        switch event.status {
        case .inProgress:
            return (.onSurfaceLv1, .onSurfaceLv1, .liveRed, .liveRed)
        case .finished:
            if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                return (.onSurfaceLv2, .onSurfaceLv1, .onSurfaceLv2, .onSurfaceLv1)
            } else if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                return (.onSurfaceLv1, .onSurfaceLv2, .onSurfaceLv1, .onSurfaceLv2)
            } else {
                return (.onSurfaceLv1, .onSurfaceLv1, .onSurfaceLv1, .onSurfaceLv1)
            }
        default:
            return (.onSurfaceLv1, .onSurfaceLv1, .onSurfaceLv1, .onSurfaceLv1)
        }
    }
}
