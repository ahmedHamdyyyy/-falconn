import 'package:flutter/material.dart';

class AppConstants {
  static const int pageTransition1200 = 1200;
  static const int pageTransition300 = 300;
  static const int pageTransition200 = 200;
  //static const int pageTransition600 = 600;
  static double  hScreen (BuildContext context ) => MediaQuery.of(context).size.height;
  static double  wScreen (BuildContext context ) => MediaQuery.of(context).size.width;
}
