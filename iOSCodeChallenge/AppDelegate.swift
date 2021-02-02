import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootNavigation = UINavigationController(rootViewController: IDResultListTableViewController())
        rootNavigation.navigationBar.prefersLargeTitles = true
        
        rootNavigation.navigationBar.barTintColor = .white
        window?.rootViewController = rootNavigation
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 225.0/255.0, green: 245.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 182.0/255.0, green: 38.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        
        return true
    }
}

