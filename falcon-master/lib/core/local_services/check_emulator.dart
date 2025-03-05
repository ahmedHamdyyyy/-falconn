import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

Future<bool> isRunningOnEmulator() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    // Check if it's a physical device
    if (androidInfo.isPhysicalDevice == false) return true;

    // Additional checks for known emulator characteristics
    bool isEmulator = androidInfo.brand.toLowerCase() == 'generic' ||
        androidInfo.device.toLowerCase() == 'generic' ||
        androidInfo.hardware.toLowerCase() == 'goldfish' ||
        androidInfo.hardware.toLowerCase() == 'ranchu' ||
        androidInfo.manufacturer.toLowerCase().contains('google') ||
        androidInfo.model.toLowerCase().contains('google_sdk') ||
        androidInfo.product.toLowerCase().contains('sdk_gphone');

    return isEmulator;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    return iosInfo.isPhysicalDevice == false;
  } else {
    return false;
  }
}
