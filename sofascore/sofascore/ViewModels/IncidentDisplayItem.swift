import Foundation

enum IncidentDisplayItem {
    case incident(IncidentViewModel)
    case period(PeriodViewModel)
}

struct PeriodViewModel {
    let title: String
    let isLive: Bool
}
