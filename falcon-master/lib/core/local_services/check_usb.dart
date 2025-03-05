import 'dart:async';

import 'package:flutter/services.dart';
import 'package:falcon/core/core_exports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class UsbConnectionChecker {
  static const platform = MethodChannel('com.falcon_elearning_2024.falcon/usb');

  void startUsbCheckTimer() {
    Timer.periodic(Duration(seconds: 4), (timer) async {
      bool isConnected = await isUsbConnected();

      if (isConnected) {

        navigatorKey.currentState?.pushAndRemoveUntil(
            PageTransition(
              child: DeveloperModeScreen(isEmulator: false, isUsbConnect: isConnected,isDeveloperMode:false),
              type: PageTransitionType.fade,
              curve: Curves.fastEaseInToSlowEaseOut,
              duration: const Duration(milliseconds: AppConstants.pageTransition200),
            ), (Route<dynamic> route) => false
        );
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     PageTransition(
        //       child: DeveloperModeScreen(isEmulator: false, isUsbConnect: isConnected,isDeveloperMode:false),
        //       type: PageTransitionType.fade,
        //       curve: Curves.fastEaseInToSlowEaseOut,
        //       duration: const Duration(milliseconds: AppConstants.pageTransition200),
        //     ), (Route<dynamic> route) => false
        // );
      }
    });
  }

  Future<bool> isUsbConnected() async {
    try {
      final bool isUsbConnected = await platform.invokeMethod('checkUsbConnection');
      return isUsbConnected;
      //return false;
    } on PlatformException catch (e) {
      return false;
    }
  }
}