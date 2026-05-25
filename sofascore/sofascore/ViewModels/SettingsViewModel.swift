import UIKit

enum Theme {
    case light
    case dark
}

struct SettingsViewModel {
    let userName: String
    let selectedTheme: Theme
    let eventCountText: String
    let leagueCountText: String
    let themeTapHandler: (Theme) -> Void
}
