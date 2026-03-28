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
        let raw = UserDefaults.standard.string(forKey: "selectedTheme") ?? "light"
        let style: UIUserInterfaceStyle = raw == "dark" ? .dark : .light
        window?.overrideUserInterfaceStyle = style
        let navigationController = UINavigationController(rootViewController: ViewController())
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
