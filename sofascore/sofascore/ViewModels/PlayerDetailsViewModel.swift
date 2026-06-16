import Foundation

struct PlayerDetailsViewModel {
    let name: String
    let imageUrl: String?
    let teamName: String
    let teamLogoUrl: String?
    let nationality: String
    let nationalityFlag: String?
    let position: String
    let jerseyNumber: String

    init(player: PlayerViewModel, teamInfo: TeamInfo) {
        name = player.name
        imageUrl = player.imageUrl
        teamName = teamInfo.team.name
        teamLogoUrl = teamInfo.team.logoUrl
        nationality = player.countryName
        nationalityFlag = player.flagUrl
        position = player.position
        jerseyNumber = player.jerseyNumber
    }
}
