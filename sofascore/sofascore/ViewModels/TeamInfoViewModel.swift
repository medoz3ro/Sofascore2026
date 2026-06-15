import Foundation

struct TeamInfoViewModel {
    let managerName: String
    let managerImageUrl: String?
    let managerCountry: String
    var managerFlagUrl: String?
    let totalPlayers: String
    let foreignPlayers: String
    let venueName: String
    let tournaments: [League]

    init(teamInfo: TeamInfo, players: [Player], tournaments: [League]) {
        managerName = teamInfo.manager?.name ?? ""
        managerImageUrl = teamInfo.manager?.imageUrl
        managerCountry = teamInfo.manager?.country?.name ?? ""
        managerFlagUrl = nil
        totalPlayers = "\(players.count)"
        foreignPlayers = "\(players.filter { $0.isForeign }.count)"
        venueName = teamInfo.venue?.name ?? ""
        self.tournaments = tournaments
    }
}
