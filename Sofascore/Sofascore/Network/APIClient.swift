import Foundation

enum APIClient {
    private static let baseURL =
        "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"

    static func fetchEvents(sport: Sport) async throws -> [Event] {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport.slug)")
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Event].self, from: data)
    }

    static func fetchEvents(
        sport: Sport,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport.slug)")
        else {
            completion(.failure(URLError(.badURL)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            do {
                let events = try JSONDecoder().decode([Event].self, from: data)
                completion(.success(events))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
