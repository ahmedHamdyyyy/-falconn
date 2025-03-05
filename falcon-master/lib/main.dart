import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:falcon/core/core_exports.dart';
import 'package:falcon/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding for async calls
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  ServicesLocator().init();


  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) =>
  //         BlocProvider(
  //           create: (context) => TimerBloc(),
  //           child: MyApp(),
  //         ), // Wrap your app
  //   ),);

  runApp(
    BlocProvider(
      create: (context) => TimerBloc(),
      child: MyApp(),
    )
    ,);

  UsbConnectionChecker().startUsbCheckTimer();

  WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
    if(Platform.isAndroid){
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
}