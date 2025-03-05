import 'package:falcon/core/core_exports.dart';


class StringRoutes {
  static const String splashRoute = "/";
  static const String developerModeDetectionRoute = "/developerModeDetection";
  static const String loginRoute = "/login";
  static const String bottomBarRoute = "/bottomBar";
}

class _PageRouting {
  static Route<dynamic> page(RouteSettings settings, Widget page) {
    return PageTransition(
      child: page,
      type: PageTransitionType.fade,
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: const Duration(milliseconds: AppConstants.pageTransition300),
      settings: settings,
    );
  }
}

class RoutesManager {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case StringRoutes.splashRoute:
        return _PageRouting.page(settings, const SplashView());

      case StringRoutes.developerModeDetectionRoute:
       return _PageRouting.page(settings, DeveloperModeDetectionScreen());

      case StringRoutes.loginRoute:
        return _PageRouting.page(settings,  LoginView());

      case StringRoutes.bottomBarRoute:
        return _PageRouting.page(settings, const BottomBarView());

      default:
        return unDefinedRoute();
    //return MaterialPageRoute(builder: (_) => SplashView());
    }
  }

  static void navToSplash(BuildContext context) {
    Navigator.pushNamed(context, StringRoutes.splashRoute);
  }

  static void navToDeveloperModeDetectionScreen(BuildContext context) {
    Navigator.pushNamed(context, StringRoutes.developerModeDetectionRoute);
  }

  static void navToLogin(BuildContext context) {
    Navigator.pushNamed(context, StringRoutes.loginRoute);
  }

  static void navToBottomBarScreens(BuildContext context) {
    Navigator.pushNamed(context, StringRoutes.bottomBarRoute);
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound)),
        ));
  }



}