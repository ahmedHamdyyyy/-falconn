import 'package:falcon/core/core_exports.dart';

class CustomEmptyComponent extends StatelessWidget {
  const CustomEmptyComponent({
    super.key,
    required this.emptyItemType,
     this.heightScreen,
     this.widthScreen,
     this.heightIcon,
     this.textFontSize,
  });

  final String emptyItemType ;
  final double? heightScreen ;
  final double? widthScreen ;
  final double? heightIcon ;
  final double? textFontSize ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightScreen?? AppConstants.hScreen(context),
      width: heightScreen?? AppConstants.wScreen(context),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical:AppPadding.pVScreen1_5(context)),
            child: Image.asset(
              AssetsManager.emptyBox,
              height: heightIcon?? AppConstants.hScreen(context)*0.1,
              color: ColorManager.darkGrey,
            ),
          ),
          Text(
            "No there any $emptyItemType !",
            style: getBoldStyle(color: ColorManager.darkGrey,fontSize: textFontSize?? FontSize.s10),
          ),
        ],
      ),
    );
  }
}