import Foundation

enum APIClient {
    private static let baseURL =
        "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"

    static func fetchSecureEvents(sport: Sport) async throws -> [Event] {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport.slug)")
        else {
            throw URLError(.badURL)
        }

        guard let token = UserSession.shared.token else {
            throw URLError(.userAuthenticationRequired)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode([Event].self, from: data)
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
}
