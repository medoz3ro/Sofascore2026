import Foundation

final class UserSession {
    static let shared = UserSession()
    private init() {}

    private let tokenKey = "authToken"
    private let nameKey = "userName"

    var token: String? {
        get { UserDefaults.standard.string(forKey: tokenKey) }
        set { UserDefaults.standard.set(newValue, forKey: tokenKey) }
    }

    var name: String? {
        get { UserDefaults.standard.string(forKey: nameKey) }
        set { UserDefaults.standard.set(newValue, forKey: nameKey) }
    }

    var isLoggedIn: Bool { token != nil }

    func save(response: LoginResponse) {
        token = response.token
        name = response.name
    }

    func clear() {
        token = nil
        name = nil
    }
}
