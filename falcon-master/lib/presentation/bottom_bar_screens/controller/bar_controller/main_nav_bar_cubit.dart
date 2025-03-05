import 'package:falcon/core/core_exports.dart';
import 'package:flutter/services.dart';

part 'main_nav_bar_state.dart';


List<Widget> mainNavPage =  [ HomeBody() , MyLearningBody() , ProfileBody() ];// TasksBody()
List<String> nameNavPages = const[ "Home", "My Learning" , "Profile"];// Tasks

class MainNavBarCubit extends Cubit<MainNavBarState> {
  int currentPage = 0;
  Widget navBody = const HomeBody();
  String navNme = "Home";

  MainNavBarCubit() : super(MainNavBarInitial());

  void chooseNavPage ({required BuildContext context,required int indexPage})async{


    UsbConnectionChecker usbChecker = UsbConnectionChecker();
    bool isConnected = await usbChecker.isUsbConnected();

    if (isConnected) {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: DeveloperModeScreen(isEmulator: false, isUsbConnect: isConnected,isDeveloperMode:false),
            type: PageTransitionType.fade,
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: AppConstants.pageTransition200),
          ), (Route<dynamic> route) => false
      );
    }else{
      currentPage = indexPage;
      navBody = mainNavPage[indexPage];
      navNme = nameNavPages[indexPage];
      emit(MainScreenChanged(currentPage:currentPage,page: navBody,navNme: navNme));
    }


  }

  }



