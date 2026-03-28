import UIKit

enum Sport: CaseIterable {
    case football
    case basketball
    case americanFootball

    var title: String {
        switch self {
        case .football: return "Football"
        case .basketball: return "Basketball"
        case .americanFootball: return "Am. Football"
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
