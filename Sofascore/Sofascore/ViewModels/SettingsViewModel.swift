import SofaAcademic
import UIKit

enum Theme {
    case light
    case dark
}

struct SettingsViewModel {
    let selectedTheme: Theme
    let themeTapHandler: (Theme) -> Void
}
