import 'package:falcon/core/core_exports.dart';



void showSnackbar({required BuildContext context , required String message ,required  Color backGroundColor, TextStyle? contentTextStyle ,int? durationMSeconds,  }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: contentTextStyle?? getBoldStyle(color: ColorManager.white),
        ),
      ),
      backgroundColor: backGroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.wScreen(context)*0.05,
        vertical: AppConstants.hScreen(context)*0.025,
      ),
      duration: Duration(milliseconds:durationMSeconds?? 1500),

    ),
  );
}