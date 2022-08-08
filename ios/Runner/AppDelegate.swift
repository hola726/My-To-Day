import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // GoogleMaps
    GMSServices.provideAPIKey("AIzaSyBq42bwVlnBe1-d-2Gk9dpdApTj24ETY8E")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
