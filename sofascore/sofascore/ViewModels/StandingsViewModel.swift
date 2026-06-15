import Foundation

struct StandingsViewModel {
    let position: String
    let teamName: String
    let teamLogoUrl: String?
    let teamId: Int
    let columns: [String]

    init(standings: Standings, sport: Sport) {
        position = "\(standings.position)"
        teamName = standings.team.name
        teamLogoUrl = standings.team.logoUrl
        teamId = standings.team.id

        switch sport {
        case .football:
            columns = [
                "\(standings.matches)",
                "\(standings.wins)",
                "\(standings.draws)",
                "\(standings.losses)",
                "\(standings.scoreFor):\(standings.scoreAgainst)",
                "\(standings.points ?? 0)",
            ]
        case .americanFootball:
            columns = [
                "\(standings.matches)",
                "\(standings.wins)",
                "\(standings.draws)",
                "\(standings.losses)",
                String(format: "%.3f", standings.percentage ?? 0),
            ]
        case .basketball:
            columns = [
                "\(standings.matches)",
                "\(standings.wins)",
                "\(standings.losses)",
                standings.scoreFormatted,
                String(format: "%.3f", standings.percentage ?? 0),
            ]
        }
    }
}
