import Foundation
import GRDB

struct EventRecord: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "event"

    let id: Int
    let homeTeamName: String
    let awayTeamName: String
    let startTimestamp: Int
    let status: String
    let homeScore: Int?
    let awayScore: Int?
    let leagueId: Int?

    init(event: Event) {
        id = event.id
        homeTeamName = event.homeTeam.name
        awayTeamName = event.awayTeam.name
        startTimestamp = event.startTimestamp
        status = event.status.rawValue
        homeScore = event.homeScore
        awayScore = event.awayScore
        leagueId = event.league?.id
    }
}

struct LeagueRecord: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "league"

    let id: Int
    let name: String
    let country: String?
    let logoUrl: String?

    init(league: League) {
        id = league.id
        name = league.name
        country = league.country?.name
        logoUrl = league.logoUrl
    }
}

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var dbQueue: DatabaseQueue!

    private init() {
        do {
            let databaseURL = try FileManager.default
                .url(
                    for: .applicationSupportDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                )
                .appendingPathComponent("sofascore.sqlite")
            dbQueue = try DatabaseQueue(path: databaseURL.path)
            try setupTables()
        } catch {
            print("Database setup error: \(error)")
        }
    }

    private func setupTables() throws {
        try dbQueue.write { db in
            try db.create(table: "event", ifNotExists: true) { t in
                t.column("id", .integer).primaryKey()
                t.column("homeTeamName", .text).notNull()
                t.column("awayTeamName", .text).notNull()
                t.column("startTimestamp", .integer).notNull()
                t.column("status", .text).notNull()
                t.column("homeScore", .integer)
                t.column("awayScore", .integer)
                t.column("leagueId", .integer)
            }

            try db.create(table: "league", ifNotExists: true) { t in
                t.column("id", .integer).primaryKey()
                t.column("name", .text).notNull()
                t.column("country", .text)
                t.column("logoUrl", .text)
            }
        }
    }

    func saveEvents(_ events: [Event]) {
        do {
            try dbQueue.write { db in
                for event in events {
                    try EventRecord(event: event).save(db)
                    if let league = event.league {
                        try LeagueRecord(league: league).save(db)
                    }
                }
            }
        } catch {
            print("Save error: \(error)")
        }
    }

    func eventCount() -> Int {
        (try? dbQueue.read { db in
            try EventRecord.fetchCount(db)
        }) ?? 0
    }

    func leagueCount() -> Int {
        (try? dbQueue.read { db in
            try LeagueRecord.fetchCount(db)
        }) ?? 0
    }

    func deleteAll() {
        do {
            try dbQueue.write { db in
                try EventRecord.deleteAll(db)
                try LeagueRecord.deleteAll(db)
            }
        } catch {
            print("Delete error: \(error)")
        }
    }
}
