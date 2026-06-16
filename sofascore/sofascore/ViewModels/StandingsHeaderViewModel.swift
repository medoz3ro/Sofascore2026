import Foundation

struct StandingsColumn {
    let title: String
    let width: CGFloat
}

struct StandingsHeaderViewModel {
    let columns: [StandingsColumn]

    static func make(for sport: Sport) -> StandingsHeaderViewModel {
        switch sport {
        case .football:
            return StandingsHeaderViewModel(columns: [
                StandingsColumn(title: "P", width: 24),
                StandingsColumn(title: "W", width: 24),
                StandingsColumn(title: "D", width: 24),
                StandingsColumn(title: "L", width: 24),
                StandingsColumn(title: "Goals", width: 40),
                StandingsColumn(title: "PTS", width: 28),
            ])
        case .americanFootball:
            return StandingsHeaderViewModel(columns: [
                StandingsColumn(title: "P", width: 24),
                StandingsColumn(title: "W", width: 24),
                StandingsColumn(title: "D", width: 24),
                StandingsColumn(title: "L", width: 24),
                StandingsColumn(title: "PCT", width: 40),
            ])
        case .basketball:
            return StandingsHeaderViewModel(columns: [
                StandingsColumn(title: "P", width: 24),
                StandingsColumn(title: "W", width: 24),
                StandingsColumn(title: "L", width: 24),
                StandingsColumn(title: "DIFF", width: 32),
                StandingsColumn(title: "PCT", width: 40),
            ])
        }
    }
}
