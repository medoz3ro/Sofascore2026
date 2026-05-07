extension APIEvent {
    func toEvent() -> Event? {
        Event(
            id: id,
            homeTeam: homeTeam.toTeam(),
            awayTeam: awayTeam.toTeam(),
            startTimestamp: startTimestamp,
            status: EventStatus(from: status),
            league: league?.toLeague(),
            homeScore: homeScore,
            awayScore: awayScore
        )
    }
}

extension APITeam {
    func toTeam() -> Team {
        Team(
            id: id,
            name: name,
            logoUrl: logoUrl,
            country: country?.toCountry()
        )
    }
}

extension APILeague {
    func toLeague() -> League {
        League(
            id: id,
            name: name,
            country: country?.toCountry(),
            logoUrl: logoUrl
        )
    }
}

extension APICountry {
    func toCountry() -> Country {
        Country(name: name)
    }
}

extension EventStatus {
    init(from string: String) {
        switch string {
        case "NOT_STARTED": self = .notStarted
        case "IN_PROGRESS": self = .inProgress
        case "HALFTIME": self = .halftime
        case "FINISHED": self = .finished
        default: self = .notStarted
        }
    }
}
