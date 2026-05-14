import Foundation

struct LeagueViewModel {
    let name: String
    let country: String
    let logoUrl: String?

    init(league: League) {
        name = league.name
        country = league.country?.name ?? ""
        logoUrl = league.logoUrl
    }
}
