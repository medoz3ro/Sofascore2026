import UIKit

enum StatViewType {
    case text
    case flag(url: String)
    case icon(image: UIImage, textColor: UIColor)
}

struct StatViewModel {
    let title: String
    let value: String
    let type: StatViewType
}
