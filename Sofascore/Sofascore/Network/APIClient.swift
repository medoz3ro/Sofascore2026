import Foundation

enum APIClient {
    private static let baseURL =
        "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"

    static func fetchSecureEvents(sport: Sport) async throws -> [Event] {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport.slug)")
        else {
            throw URLError(.badURL)
        }
        let urlRequest = try authorizedRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode([Event].self, from: data)
    }

    static func fetchIncidents(eventId: Int) async throws -> [Incident] {
        guard let url = URL(string: "\(baseURL)/events/\(eventId)/incidents")
        else {
            throw URLError(.badURL)
        }
        let urlRequest = try authorizedRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode([Incident].self, from: data)
    }

    static func login(request: LoginRequest) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseURL)/login") else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        urlRequest.httpBody = try JSONEncoder().encode(request)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }

    private static func authorizedRequest(url: URL) throws -> URLRequest {
        guard let token = UserSession.shared.token else {
            throw URLError(.userAuthenticationRequired)
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
