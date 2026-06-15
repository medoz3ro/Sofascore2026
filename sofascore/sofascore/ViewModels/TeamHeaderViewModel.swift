import Foundation

struct TeamHeaderViewModel {
    let teamName: String
    let logoUrl: String?
    let countryName: String
    var flagUrl: String?

    init(teamInfo: TeamInfo) {
        teamName = teamInfo.team.name
        logoUrl = teamInfo.team.logoUrl
        countryName = teamInfo.team.country?.name ?? ""
        flagUrl = nil
    }
}
