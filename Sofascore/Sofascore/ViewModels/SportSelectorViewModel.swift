import SofaAcademic
import UIKit

struct SportSelectorViewModel {
    let sports: [SportTabViewModel]

    static func defaultSports() -> SportSelectorViewModel {
        SportSelectorViewModel(sports: [
            SportTabViewModel(
                icon: UIImage(named: "football_icon"),
                title: .football,
                isSelected: true
            ),
            SportTabViewModel(
                icon: UIImage(named: "basketball_icon"),
                title: .basketball,
                isSelected: false
            ),
            SportTabViewModel(
                icon: UIImage(named: "americanFootball_icon"),
                title: .americanFootball,
                isSelected: false
            ),
        ])
    }
}
