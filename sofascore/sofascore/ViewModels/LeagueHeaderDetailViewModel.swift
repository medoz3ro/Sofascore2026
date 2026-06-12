import Foundation

struct LeagueHeaderDetailViewModel {
    let leagueName: String
    let countryName: String
    let logoUrl: String?
    var flagUrl: String?

    init(league: League) {
        leagueName = league.name
        countryName = league.country?.name ?? ""
        logoUrl = league.logoUrl
        flagUrl = nil
    }
}
