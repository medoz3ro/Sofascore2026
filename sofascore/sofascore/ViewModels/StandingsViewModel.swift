struct StandingsViewModel {
    let position: String
    let teamName: String
    let teamLogoUrl: String?
    let matches: String
    let wins: String
    let losses: String
    let draws: String
    let goals: String
    let points: String

    init(standings: Standings) {
        position = "\(standings.position)"
        teamName = standings.team.name
        teamLogoUrl = standings.team.logoUrl
        matches = "\(standings.matches)"
        wins = "\(standings.wins)"
        losses = "\(standings.losses)"
        draws = "\(standings.draws)"
        goals = "\(standings.scoreFor):\(standings.scoreAgainst)"
        points = "\(standings.points)"
    }
}
