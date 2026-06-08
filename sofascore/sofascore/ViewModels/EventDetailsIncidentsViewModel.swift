import Foundation

struct EventDetailsIncidentsViewModel {
    static func buildDisplayItems(
        from incidents: [Incident],
        sport: Sport,
        status: EventStatus
    ) -> [IncidentDisplayItem] {
        let filtered = incidents.compactMap { incident -> IncidentViewModel? in
            if case .unknown = incident { return nil }
            return IncidentViewModel(incident: incident, sport: sport)
        }

        var items: [IncidentDisplayItem] = []
        var insertedPeriods: Set<String> = []

        let periodBreaks: [(minute: Int, title: String)] = {
            switch sport {
            case .football:
                return [(45, "HT")]
            case .americanFootball:
                return [(15, "1Q"), (30, "2Q"), (45, "3Q")]
            case .basketball:
                return [(10, "1Q"), (20, "2Q"), (30, "3Q")]
            }
        }()

        for viewModel in filtered {
            if let minute = Int(
                viewModel.minute.replacingOccurrences(of: "'", with: "")
            ) {
                for period in periodBreaks {
                    if minute > period.minute
                        && !insertedPeriods.contains(period.title)
                    {
                        let lastScore =
                            items.last.flatMap {
                                if case .incident(let vm) = $0 {
                                    return vm.score
                                }
                                return nil
                            } ?? ""
                        let periodTitle =
                            sport == .basketball
                            ? period.title
                            : "\(period.title) (\(lastScore))"
                        let isLive =
                            status == .inProgress || status == .halftime
                        items.append(
                            .period(
                                PeriodViewModel(
                                    title: periodTitle,
                                    isLive: isLive
                                )
                            )
                        )
                        insertedPeriods.insert(period.title)
                    }
                }
            }
            items.append(.incident(viewModel))
        }

        if status == .finished {
            let ftScore = filtered.last?.score ?? ""
            let ftTitle = sport == .basketball ? "FT" : "FT (\(ftScore))"
            items.append(
                .period(PeriodViewModel(title: ftTitle, isLive: false))
            )
        } else if status == .halftime {
            let htScore = filtered.last?.score ?? ""
            let htTitle = sport == .basketball ? "HT" : "HT (\(htScore))"
            items.append(.period(PeriodViewModel(title: htTitle, isLive: true)))
        } else if status == .inProgress {
            let currentScore = filtered.last?.score ?? ""
            let currentPeriod =
                periodBreaks.last { insertedPeriods.contains($0.title) }?.title
                ?? periodBreaks.first?.title
                ?? "1Q"
            let currentTitle =
                sport == .basketball || sport == .americanFootball
                ? currentPeriod
                : "\(currentPeriod) (\(currentScore))"
            items.append(
                .period(PeriodViewModel(title: currentTitle, isLive: true))
            )
        }

        return items.reversed()
    }
}
