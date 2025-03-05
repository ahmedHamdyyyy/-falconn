part of 'main_nav_bar_cubit.dart';

@immutable
abstract class MainNavBarState {}

class MainNavBarInitial extends MainNavBarState {}

// ignore: must_be_immutable
class MainScreenChanged extends MainNavBarState {
  int currentPage = 0 ;
  Widget? page = const HomeBody() ;
  String navNme = "Home";

  MainScreenChanged({required this.currentPage , required this.page,required this.navNme});

}
