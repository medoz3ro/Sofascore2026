import Foundation

struct PlayerViewModel {
    let name: String
    let position: String
    let jerseyNumber: String
    let countryName: String
    let imageUrl: String?
    var flagUrl: String?

    init(player: Player) {
        name = player.name
        position = player.position
        jerseyNumber = player.jerseyNumber ?? ""
        countryName = player.country?.name ?? ""
        imageUrl = player.imageUrl
        flagUrl = CountryFlagOverride.flagUrl(for: player.country?.name ?? "")
    }
}
