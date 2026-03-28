import SofaAcademic
import UIKit

struct SportTabViewModel {
    let sport: Sport
    let isSelected: Bool

    var icon: UIImage? { sport.image }
    var title: String { sport.title }
}
