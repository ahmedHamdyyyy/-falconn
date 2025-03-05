import 'package:falcon/core/core_exports.dart';

class SetPasswordBottomSheet extends StatefulWidget {
  @override
  _SetPasswordBottomSheetState createState() => _SetPasswordBottomSheetState();
}

class _SetPasswordBottomSheetState extends State<SetPasswordBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller =
        BottomSheet.createAnimationController(this);
    controller.duration = Duration(seconds:1 );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          transitionAnimationController: controller,
          showDragHandle: true,
          backgroundColor: ColorManager.backWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.r24),
            ),
          ),

          builder: (context) {
            return Container(
              height: AppConstants.hScreen(context)*0.646,
              padding:  EdgeInsets.symmetric(horizontal: AppConstants.wScreen(context)*0.055 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Change Password",
                      style:getBoldStyle(color: ColorManager.black.withOpacity(0.8),fontSize: FontSize.s20),
                    ),
                  ),

                  SizedBox(
                    height:  AppConstants.hScreen(context)*0.03,
                  ),
                  CustomTextFormField(
                    hintText: "Current Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.visibility_rounded,size: 22,color: ColorManager.textGrey.withOpacity(0.8),),
                    ),
                    marginVerticalSides:  AppConstants.hScreen(context)*0.01,
                    prefixIcon: Icon(Icons.lock_outline_rounded,color: ColorManager.black.withOpacity(0.6),),
                    borderColor: ColorManager.black.withOpacity(0.5),
                  ),
                  CustomTextFormField(
                    hintText: "New Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.visibility_rounded,size: 22,color: ColorManager.textGrey.withOpacity(0.8),),
                    ),
                    marginVerticalSides:  AppConstants.hScreen(context)*0.01,
                    prefixIcon: Icon(Icons.lock_outline_rounded,color: ColorManager.black.withOpacity(0.6),),
                    borderColor: ColorManager.black.withOpacity(0.5),
                  ),
                  CustomTextFormField(
                    hintText: "Confirm Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.visibility_rounded,size: 22,color: ColorManager.textGrey.withOpacity(0.8),),
                    ),
                    marginVerticalSides:  AppConstants.hScreen(context)*0.01,
                    prefixIcon: Icon(Icons.lock_outline_rounded,color: ColorManager.black.withOpacity(0.6),),
                    borderColor: ColorManager.black.withOpacity(0.5),
                  ),
                  SizedBox(
                    height:  AppConstants.hScreen(context)*0.01,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onPressed: (){
                        //RoutingHelper.navToLoginReplace(context);
                      },
                      text: "Change",



                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon:Icon(Icons.arrow_forward_ios_rounded,color: ColorManager.textGrey,),
    );
  }
}

