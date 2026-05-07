struct APICountry: Codable {
    let name: String
}

struct APITeam: Codable {
    let id: Int
    let name: String
    let logoUrl: String?
    let country: APICountry?
}

struct APILeague: Codable {
    let id: Int
    let name: String
    let country: APICountry?
    let logoUrl: String?
    let seasonId: Int?
}

struct APIEvent: Codable {
    let id: Int
    let homeTeam: APITeam
    let awayTeam: APITeam
    let startTimestamp: Int
    let status: String
    let league: APILeague?
    let homeScore: Int?
    let awayScore: Int?
}
