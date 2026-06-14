import Foundation

struct StandingsHeaderViewModel {
    let col1: String
    let col2: String
    let col3: String
    let col4: String
    let col5: String
    let lastCol: String
    let showLastCol: Bool

    static func make(for sport: Sport) -> StandingsHeaderViewModel {
        switch sport {
        case .football:
            return StandingsHeaderViewModel(col1: "W", col2: "D", col3: "L", col4: "Goals", col5: "P", lastCol: "PTS", showLastCol: true)
        case .americanFootball:
            return StandingsHeaderViewModel(col1: "W", col2: "D", col3: "L", col4: "PCT", col5: "P", lastCol: "", showLastCol: false)
        case .basketball:
            return StandingsHeaderViewModel(col1: "W", col2: "L", col3: "GB", col4: "PCT", col5: "P", lastCol: "", showLastCol: false)
        }
    }
}
