import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
  // This is required to make any communication available in the action isolate.
  GeneratedPluginRegistrant.register(with: self)
  return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
