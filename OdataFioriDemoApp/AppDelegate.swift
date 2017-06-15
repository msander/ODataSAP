//
// AppDelegate.swift
// OdataFioriDemoApp
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 09/06/17
//

import UIKit
import SAPFiori
import SAPFoundation
import SAPCommon
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UISplitViewControllerDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?

    var espmContainer: ESPMContainerDataAccess!
    var urlSession: SAPURLSession? {
        didSet {
            self.espmContainer = ESPMContainerDataAccess(urlSession: urlSession!)
        }
    }
    
    var isLoginSuccessful = false
    private let logger: Logger = Logger.shared(named: "AppDelegateLogger")
    private var deviceToken: Data?
    private var remoteNotificationClient: SAPcpmsRemoteNotificationClient!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        UINavigationBar.applyFioriStyle()
        
        let splitVC = self.window!.rootViewController as! UISplitViewController
        let leftNavController = splitVC.viewControllers.first as! UINavigationController
        let masterViewController = leftNavController.topViewController as! CollectionsTableViewController
        let rightNavController = splitVC.viewControllers[1] as! UINavigationController
        let detailViewController = rightNavController.topViewController as! MasterTableViewController
        masterViewController.delegate = detailViewController
        
        
        // Show the actual authentication' view controller
        self.window?.makeKeyAndVisible()
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
        if (storyboard != nil) {
            let splitViewController = self.window!.rootViewController as! UISplitViewController
            let logonViewController = (storyboard?.instantiateViewController(withIdentifier: "BasicAuth"))! as! BasicAuthViewController
            splitViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            splitViewController.preferredDisplayMode = .allVisible
            splitViewController.present(logonViewController, animated: false, completion: {})
        }
        
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
//        let urlSession = SAPURLSession(configuration: URLSessionConfiguration.default)
//        urlSession.register(SAPcpmsObserver(applicationID: Constants.appId, deviceID: UIDevice.current.identifierForVendor!.uuidString))
//        self.urlSession = urlSession
        
        return true
    }

    
    // MARK: - Remote Notification handling
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            // Enable or disable features based on authorization.
        }
        center.delegate = self
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
//        guard let topAsMasterController = secondaryAsNavController.topViewController as? MasterViewController else { return false }
//        // Without this, on iPhone the main screen is the detailview and the masterview can not be reached.
//        if (topAsMasterController.collectionType == .none) {
//            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//            return true
//        }
//        
//        return false
        
        return true;
    }
    
    
    func registerForRemoteNotification() -> Void {
        guard let deviceToken = self.deviceToken else {
            // Device token has not been acquired
            return
        }
        
        self.remoteNotificationClient = SAPcpmsRemoteNotificationClient(sapURLSession: self.urlSession!, settingsParameters: Constants.configurationParameters)
        self.remoteNotificationClient.registerDeviceToken(deviceToken, completionHandler: { (error: Error?) -> Void in
            if error != nil {
                self.logger.error("Register DeviceToken failed")
            } else {
                self.logger.info("Register DeviceToken succeeded")
            }
        })
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
    
        self.deviceToken = deviceToken
    
    
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.logger.error("Failed to register for Remote Notification")
    }
    
    // Called to let your app know which action was selected by the user for a given notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping() -> Void) {
        self.logger.info("App opened via user selecting notification: \(response.notification.request.content.body)")
        // Here is where you want to take action to handle the notification, maybe navigate the user to a given screen.
        completionHandler()
    }
    
    // Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        self.logger.info("Remote Notification arrived while app was in forground: \(notification.request.content.body)")
        // Currently we are presenting the notification alert as the application were in the backround.
        // If you have handled the notification and do not want to display an alert, call the completionHandle with empty options: completionHandler([])
        print("\(notification.request.content.body)")
        FUIToastMessage.show(message: notification.request.content.body, icon: UIImage(named: "tick")!, inWindow: self.window!, withDuration: 5.0, maxNumberOfLines: 1)
        //FUIToastMessage.sh
        completionHandler([.alert, .sound, .badge])
    }

}
