import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UINavigationControllerDelegate {

    var window: UIWindow?

    private var rootViewController: UIViewController {
        if UserDefaults.standard.bool(forKey: "isAuthenticated") {
            return ViewController()
        }
        return LoginViewController()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
    }
    
    func updateRootViewController () {
        guard let window = window else {
            return
        }
        
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
    }
}
