import Foundation

struct Country: Codable {
    let name: String
}

struct Team: Codable {
    let id: Int
    let name: String
    let logoUrl: String?
    let country: Country?
}

struct League: Codable {
    let id: Int
    let name: String
    let country: Country?
    let logoUrl: String?
    let seasonId: Int?
}

enum EventStatus: String, Codable {
    case notStarted = "NOT_STARTED"
    case inProgress = "IN_PROGRESS"
    case halftime = "HALFTIME"
    case finished = "FINISHED"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = EventStatus(rawValue: rawValue) ?? .notStarted
    }
}

struct Event: Codable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int
    let status: EventStatus
    let league: League?
    let homeScore: Int?
    let awayScore: Int?
}
