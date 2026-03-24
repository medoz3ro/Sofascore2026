import SofaAcademic
import UIKit

enum Theme {
    case light
    case dark
}

struct SettingsViewModel {
    let title: String
    let selectedTheme: Theme
}
