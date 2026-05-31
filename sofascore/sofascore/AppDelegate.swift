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

    func switchToLogin() {
        window?.rootViewController = makeLoginNavigationController()
    }

    func switchToEvents() {
        window?.rootViewController = makeEventsNavigationController()
    }

    private func makeLoginNavigationController() -> UINavigationController {
        let nav = UINavigationController(
            rootViewController: LoginViewController()
        )
        nav.isNavigationBarHidden = true
        return nav
    }

    private func makeEventsNavigationController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: ViewController())
        nav.isNavigationBarHidden = true
        return nav
    }
}
