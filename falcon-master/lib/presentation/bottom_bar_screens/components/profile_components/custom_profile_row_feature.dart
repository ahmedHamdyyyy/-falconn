import 'package:falcon/core/core_exports.dart';


class CustomProfileRowFeature extends StatelessWidget {
  CustomProfileRowFeature({
    super.key,
    required this.iconSvg,
    required this.title,
    required this.onPressed,
    this.paddingBottom,
    this.isHasSwitch,
    this.switchWidget,

  });

  String iconSvg;
  String title;
  double? paddingBottom;
  bool? isHasSwitch;
  Widget? switchWidget ;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r4),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: paddingBottom ?? 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  iconSvg,
                  colorFilter:
                      ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
                  width: AppConstants.wScreen(context) * 0.04,
                  height: AppConstants.hScreen(context) * 0.04,
                ),
                SizedBox(
                  width: AppConstants.wScreen(context) * 0.03,
                  height: AppConstants.hScreen(context) * 0.05,
                ),
                Text(
                  title,
                  style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),
                ),

              ],
            ),
          ),
        ),
        Spacer(),
        (isHasSwitch==true)
            ?switchWidget??SizedBox()
            :SizedBox(),

        SizedBox(
          width: AppConstants.wScreen(context)*0.04,
        ),
      ],
    );
  }
}

