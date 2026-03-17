import SofaAcademic
import UIKit

struct SportSelectorViewModel {
    let sports: [SportTabViewModel]

    static func defaultSports() -> SportSelectorViewModel {
        SportSelectorViewModel(sports: [
            SportTabViewModel(
                icon: UIImage(named: "football_icon"),
                title: "Football",
                isSelected: true
            ),
            SportTabViewModel(
                icon: UIImage(named: "basketball_icon"),
                title: "Basketball",
                isSelected: false
            ),
            SportTabViewModel(
                icon: UIImage(named: "americanFootball_icon"),
                title: "Am. Football",
                isSelected: false
            )
        ])
    }
}
