import 'package:falcon/core/core_exports.dart';
class CustomRectangleImageBack extends StatelessWidget {
  CustomRectangleImageBack({
    Key? key,
    this.top,
    this.bottom,
  }) : super(key: key);

  final bool? top;
  final bool? bottom;

  @override
  Widget build(BuildContext context) {
    final double _heightScreen = MediaQuery.of(context).size.height;
    final double _widthScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (top==true || top == null)
            ? Align(
                alignment: Alignment.topRight,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SvgPicture.asset(
                      AssetsManager.rectangleTop,
                      colorFilter: ColorFilter.mode(ColorManager.lightPrimary, BlendMode.srcIn),
                      width: _widthScreen * 0.5,
                      height: _heightScreen * 0.088,
                      // width: _widthScreen * 0.484,
                      // height: _heightScreen * 0.167, //142
                    ),
                    SvgPicture.asset(
                      AssetsManager.rectangleTop,
                      colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
                      height: _heightScreen * 0.08, //114
                      //height: _heightScreen * 0.134, //114
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        (bottom==true || bottom == null)
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    SvgPicture.asset(
                      AssetsManager.rectangleDown,
                      colorFilter: ColorFilter.mode(ColorManager.lightPrimary, BlendMode.srcIn),
                      width: _widthScreen * 0.3,
                      height: _heightScreen * 0.06,
                      // width: _widthScreen * 0.339,
                      // height: _heightScreen * 0.098,
                    ),
                    SvgPicture.asset(
                      AssetsManager.rectangleDown,
                      colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
                      height: _heightScreen * 0.056,
                      //height: _heightScreen * 0.065,
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
