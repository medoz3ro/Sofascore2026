import SofaAcademic
import UIKit

struct SportSelectorViewModel {
    let sports: [SportTabViewModel]

    static func defaultSports() -> SportSelectorViewModel {
        SportSelectorViewModel(
            sports: Sport.allCases.enumerated().map { index, sport in
                SportTabViewModel(
                    title: sport.title,
                    image: sport.image,
                    isSelected: index == 0
                )
            }
        )
    }
}
