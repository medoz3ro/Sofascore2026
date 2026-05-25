import Foundation

struct LoginViewModel {
    let onLoginSuccess: (LoginResponse) -> Void
    let onLoginFailure: (String) -> Void

    func login(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            onLoginFailure("Please enter username and password.")
            return
        }

        Task { @MainActor in
            do {
                let response = try await APIClient.login(
                    request: LoginRequest(
                        username: username,
                        password: password
                    )
                )
                onLoginSuccess(response)
            } catch {
                onLoginFailure("Login failed. Check your credentials.")
            }
        }
    }
}
