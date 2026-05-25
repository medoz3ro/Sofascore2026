import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let raw =
            UserDefaults.standard.string(forKey: "selectedTheme") ?? "light"
        let style: UIUserInterfaceStyle = raw == "dark" ? .dark : .light
        window?.overrideUserInterfaceStyle = style

        let rootVC =
            UserSession.shared.isLoggedIn
            ? makeEventsNavigationController()
            : makeLoginNavigationController()

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }

    private func makeEventsNavigationController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: ViewController())
        nav.isNavigationBarHidden = true
        return nav
    }

    private func makeLoginNavigationController() -> UINavigationController {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak self] response in
            UserSession.shared.save(response: response)
            self?.switchToEvents()
        }
        let nav = UINavigationController(rootViewController: loginVC)
        nav.isNavigationBarHidden = true
        return nav
    }

    func switchToEvents() {
        window?.rootViewController = makeEventsNavigationController()
    }
}
