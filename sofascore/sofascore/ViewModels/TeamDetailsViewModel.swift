import Foundation

enum TeamTab {
    case details
    case players
}

struct TeamDetailsViewModel {

    let teamId: Int

    func fetchTeamInfo() async throws -> TeamInfo {
        try await APIClient.fetchTeamInfo(teamId: teamId)
    }

    func fetchPlayers() async throws -> [Player] {
        try await APIClient.fetchTeamPlayers(teamId: teamId)
    }

    func fetchTournaments() async throws -> [League] {
        try await APIClient.fetchTeamTournaments(teamId: teamId)
    }
}
