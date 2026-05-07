import Foundation

final class APIClient {
    static let shared = APIClient()

    private let baseURL =
        "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"

    private init() {}

    func fetchEvents(sport: Sport) async throws -> [Event] {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport.slug)")
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiEvents = try JSONDecoder().decode([APIEvent].self, from: data)
        return apiEvents.compactMap { $0.toEvent() }
    }
}
