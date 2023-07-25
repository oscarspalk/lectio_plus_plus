import UIKit
import Flutter
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  // This is required to make any communication available in the action isolate.
WorkmanagerPlugin.registerTask(withIdentifier: "com.oscarspalk.lpp.fetch")
  GeneratedPluginRegistrant.register(with: self)
          UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
  return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
}
