struct Country {
    let name: String
}

struct Team {
    let id: Int
    let name: String
    let logoUrl: String?
    let country: Country?
}

struct League {
    let id: Int
    let name: String
    let country: Country?
    let logoUrl: String?
}

enum EventStatus {
    case notStarted
    case inProgress
    case halftime
    case finished
}

struct Event {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int
    let status: EventStatus
    let league: League?
    let homeScore: Int?
    let awayScore: Int?
}
