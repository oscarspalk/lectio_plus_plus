import UIKit
import Flutter
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  GeneratedPluginRegistrant.register(with: self)
      WorkmanagerPlugin.registerPeriodicTask(
        withIdentifier: "com.oscarspalk.lpp.notification",
        frequency: NSNumber(value: 20 * 60)
      )

      
  return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
