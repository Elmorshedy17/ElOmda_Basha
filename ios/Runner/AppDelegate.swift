import Firebase
import FirebaseMessaging
import Flutter
import GoogleMaps
import UIKit
import UserNotificationsUI
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        var flutter_native_splash = 1
        UIApplication.shared.isStatusBarHidden = false
        GMSServices.provideAPIKey("AIzaSyAWxomwJys-vAXdtyrreAkGHTBJoZcWCt8")
        setUpRemoteNotification(application: application)
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    fileprivate func setUpRemoteNotification(application: UIApplication) {
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.badge, .alert, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
            Messaging.messaging().delegate = self
        } else {
            Messaging.messaging().delegate = self
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {}
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {}
}

extension AppDelegate
{
    // Receive displayed notifications for iOS 10 devices.
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                         willPresent notification: UNNotification,
                                         withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                         didReceive response: UNNotificationResponse,
                                         withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
