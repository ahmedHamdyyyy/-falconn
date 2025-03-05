import 'package:falcon/core/core_exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.context,
    required this.title,
    this.centerTitle ,
    this.hasArrowBack = false,
    this.hasTitle = true,
    this.hasCenterWidget = false,
    this.hasActions = false,
    this.centerWidget ,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.arrowColor,
    this.appBarHeight,
    this.elevation,
    this.shadowColor,
    this.bottom,
    this.leadingWidget,
  });

  String title;
  BuildContext context;
  bool? centerTitle;
  bool hasArrowBack;
  bool hasTitle;
  bool hasCenterWidget;
  bool hasActions;
  Widget? centerWidget ;
  List<Widget>? actions;
  Color? backgroundColor ;
  Color? titleColor ;
  Color? arrowColor ;
  double? appBarHeight ;
  double? elevation ;
  Color? shadowColor ;
  PreferredSizeWidget? bottom;
  Widget? leadingWidget ;


  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    return AppBar(
      scrolledUnderElevation: elevation??3.5,
      title: hasCenterWidget
          ?centerWidget
          :hasTitle?Padding(
      padding: EdgeInsets.only(top: heightScreen * 0.03),
      child: Text(
        title,
        style: getBoldStyle(color:titleColor??ColorManager.black,fontSize: 18),
      ),
    )
          :SizedBox(),
      elevation: elevation??0,
      shadowColor: shadowColor??ColorManager.primary,
      backgroundColor: backgroundColor?? ColorManager.white,
      leading: (hasArrowBack != false)
          ? GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: heightScreen * 0.03),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: arrowColor??ColorManager.primary,
                ),
              ),
            )
          : (leadingWidget!=null)?leadingWidget:const SizedBox(),
      centerTitle: centerTitle??true,
      actions: (hasActions==true)?actions??[]:[],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBarHeight?? MediaQuery.of(context).size.height * 0.09);
}
