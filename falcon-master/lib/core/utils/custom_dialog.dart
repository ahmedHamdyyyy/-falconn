import 'dart:async';

import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class CustomDialog extends StatelessWidget {
  final String title, description;
  final Image? image;
  String typeContent;
  String id;
  final bool isChargeWallet;
  final double amount;

  final TextEditingController codeController = TextEditingController();
   GlobalKey<FormState> codeFormKey = GlobalKey() ;

  CustomDialog({
    required this.title,
    required this.description,
    required this.isChargeWallet,
    required this.amount,
    required this.typeContent,
    required this.id,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pHScreen6(context),
          vertical: AppPadding.pVScreen2(context),
        ),
        margin: EdgeInsets.only(
          top: AppConstants.hScreen(context)*0.15,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppRadius.r14),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.2),
              blurRadius: 8.0,
              offset: const Offset(0.0, 8.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title.toLowerCase(),
              textAlign: TextAlign.center,
              style:getBoldStyle(color: ColorManager.black,fontSize: FontSize.s16),
            ),
            SizedBox(height: AppPadding.pVScreen2(context),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style:getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s12),
            ),
            SizedBox(height: AppPadding.pVScreen2(context)),
            Form(
              key: codeFormKey,
              child: CustomTextFormField(
                hintText: "Code",
                controller: codeController,
                hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s12),
                textStyle: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s12),
                heightFilled: AppConstants.hScreen(context)*0.1,
                validation: (value){
                  if( value==null || value ==""){
                    return"*code required";
                  }
                },

              ),
            ),
            SizedBox(height: AppPadding.pVScreen2(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text:"Cancel",
                  widthButton:AppConstants.wScreen(context)*0.3,
                  textStyle: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s12),
                  heightButton: AppConstants.hScreen(context)*0.05,
                  backgroundColor: ColorManager.darkGrey.withOpacity(0.6),
                ),
                BlocBuilder<ByAnyContentBloc,ByAnyContentState>(
                    builder: (context,stateBaying) {
                      return CustomButton(
                        onPressed: () async{
                          if(isChargeWallet ==false && codeFormKey.currentState!.validate()){
                            await context.read<ByAnyContentBloc>()..add(ByAnyContentEventRequestEvent(
                                id: id.toString(),
                                type:typeContent.toString(),
                                studentId:context.read<CurrentUserBloc>().userData!.id.toString(),
                                code: codeController.text
                            ));

                            if(stateBaying is ByAnyContentRequestState && stateBaying.requestState ==RequestState.loading){
                              showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"Waiting...",),);

                            }

                            if(stateBaying is ByAnyContentRequestState && stateBaying.requestState ==RequestState.error){
                              showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"${stateBaying.responseMessage}",),);
                              Navigator.pop(context);
                            }
                            if(stateBaying is ByAnyContentRequestState && stateBaying.requestState ==RequestState.done){
                              showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"${stateBaying.responseMessage}"),);
                              Navigator.pop(context);

                            }


                            // await Future.delayed(Duration(seconds:2),(){
                            //   if(codeController=="123"){
                            //     showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"success purchased",),);
                            //   }else{
                            //     showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"Failed purchased",),);
                            //   }
                            // });

                           // Navigator.of(context).pop();

                          }

                          if(isChargeWallet  && codeFormKey.currentState!.validate() ){
                            await context.read<ValidateCodeChargeBloc>()..add(ValidateCodeChargeRequestEvent(
                                studentId: int.parse(context.read<CurrentUserBloc>().userData!.id),
                                code: codeController.text
                            ));

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.push(context, PageTransition(
                              child: WalletView(),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: 0),
                            ));
                            Navigator.of(context).pop();
                            Navigator.push(context, PageTransition(
                              child: WalletView(),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: 0),
                            ));
                            Navigator.of(context).pop();
                            Navigator.push(context, PageTransition(
                              child: WalletView(),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: 0),
                            ));
                            Navigator.of(context).pop();
                            Navigator.push(context, PageTransition(
                              child: WalletView(),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: 0),
                            ));
                            Navigator.of(context).pop();
                            Navigator.push(context, PageTransition(
                              child: WalletView(),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: 0),
                            ));
                            Navigator.of(context).pop();
                            Navigator.push(context, PageTransition(
                              child: WalletView(),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: 0),
                            ));


                          }
                        },
                        text:"Get it",
                        widthButton:AppConstants.wScreen(context)*0.3,
                        textStyle: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s12),
                        heightButton: AppConstants.hScreen(context)*0.05,
                      );
                    }
                ),
              ],
            ),
            SizedBox(height: AppPadding.pVScreen2(context)),
          ],
        ),
      ),
    );
  }
}
