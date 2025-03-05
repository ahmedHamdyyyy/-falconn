import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    self.window?.secureApp() // Prevent screenshots
    GeneratedPluginRegistrant.register(with: self)

    // Set up the MethodChannel for USB connection check
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let usbChannel = FlutterMethodChannel(name: "com.falcon_elearning_2024.falcon/usb",
                                          binaryMessenger: controller.binaryMessenger)

    usbChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "checkUsbConnection" {
        let isUsbConnected = self.checkUsbConnection() // Use the method below to handle USB check
        result(isUsbConnected)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    // Observe screen recording changes
    NotificationCenter.default.addObserver(self, selector: #selector(screenCaptureChanged), name: UIScreen.capturedDidChangeNotification, object: nil)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Method to handle screen recording detection
  @objc func screenCaptureChanged() {
      if UIScreen.main.isCaptured {
          // Hide sensitive content when screen recording is detected
          self.window?.isHidden = true
      } else {
          // Show content again when screen recording stops
          self.window?.isHidden = false
      }
  }

  // Sample method to check USB connection (this is a placeholder for now)
  private func checkUsbConnection() -> Bool {
    // iOS doesn't have direct APIs to check USB, return false for now or implement custom logic
    return false
  }
}

// Extension to prevent screenshots
extension UIWindow {
  func secureApp() {
    let field = UITextField()
    field.isSecureTextEntry = true
    self.addSubview(field)
    field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      field.removeFromSuperview()
    }
  }
}

/*

import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    self.window.secureApp()
    GeneratedPluginRegistrant.register(with: self)

    // Set up the MethodChannel for USB connection check
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let usbChannel = FlutterMethodChannel(name: "com.falcon_elearning_2024.falcon/usb",
                                          binaryMessenger: controller.binaryMessenger)

    usbChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "checkUsbConnection" {
        let isUsbConnected = self.checkUsbConnection() // Use the method below to handle USB check
        result(isUsbConnected)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Sample method to check USB connection (this is a placeholder for now)
  private func checkUsbConnection() -> Bool {
    // iOS doesn't have direct APIs to check USB, return false for now or implement custom logic
    return false
  }
}

extension UIWindow {
  func secureApp() {
    let field = UITextField()
    field.isSecureTextEntry = true
    self.addSubview(field)
    field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayers?.first?.addSublayer(self.layer)
  }
}
 */
