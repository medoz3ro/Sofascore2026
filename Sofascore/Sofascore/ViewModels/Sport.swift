import UIKit

enum Sport: CaseIterable {
    case football
    case basketball
    case americanFootball

    var title: String {
        switch self {
        case .football: return .football
        case .basketball: return .basketball
        case .americanFootball: return .americanFootball
        }
    }

    var image: UIImage? {
        switch self {
        case .football: return UIImage(named: "football_icon")
        case .basketball: return UIImage(named: "basketball_icon")
        case .americanFootball: return UIImage(named: "americanFootball_icon")
        }
    }
}
