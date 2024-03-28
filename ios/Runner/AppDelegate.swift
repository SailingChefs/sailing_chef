import UIKit
import Flutter
// import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // GMSServices.provideAPIKey("AIzaSyDyjNw2mLbZ1ZP5tYVrJZJkFb5p9o6sGd8")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
