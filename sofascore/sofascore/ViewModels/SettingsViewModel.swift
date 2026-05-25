import UIKit

enum Theme {
    case light
    case dark
}

struct SettingsViewModel {
    let userName: String
    let selectedTheme: Theme
    let themeTapHandler: (Theme) -> Void
}
