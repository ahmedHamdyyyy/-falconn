import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GetContentBottom extends StatefulWidget {
  const GetContentBottom({
    required this.id,
    required this.price,
    required this.typeContent,
    required this.title,
    this.isTextBottom,
    super.key,
  });

  final String id;
  final String title;
  final double price;
  final DetailsType typeContent ;
  final bool? isTextBottom ;
  @override
  State<GetContentBottom> createState() => _GetContentBottomState();
}

class _GetContentBottomState extends State<GetContentBottom> with TickerProviderStateMixin{
  late TextEditingController codePurchaseController;
  late AnimationController typePurchaseSheetController;


  @override
  void initState() {
    codePurchaseController = TextEditingController();
    typePurchaseSheetController = BottomSheet.createAnimationController(this);
    typePurchaseSheetController.duration = const Duration(seconds:1 );


    super.initState();
  }

  @override
  void dispose() {
    codePurchaseController.dispose();
    typePurchaseSheetController.dispose();
    super.dispose();
  }
  void _typePurchaseSheet (BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      transitionAnimationController: typePurchaseSheetController,
      showDragHandle: true,
      isDismissible :false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.r24),
        ),
      ),
      builder: (context) {
        return Container(
          height: AppConstants.hScreen(context)*0.4,
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.pHScreen6(context),
          ),
          child: Column(
            children: [
              SizedBox(height: AppPadding.pVScreen2(context),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.pHScreen2(context),),
                child: Text(
                  widget.title,
                  style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                ),
              ),
              SizedBox(height: AppPadding.pVScreen2(context),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.pHScreen2(context),),
                child: Text(
                  "If you get it by code , you will get it immediately, but if you request it, you will wait for acceptance",
                  style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              /*
              Module,
  Subject,
  Chapter,
  LastChapter,
              * */
              // BlocBuilder<ByAnyContentBloc,ByAnyContentState>(
              //     builder: (context,stateBaying) {
              //     return CustomButton(
              //       onPressed: ()async{
              //         await typePurchaseSheetController.reverse();
              //
              //          context.read<ByAnyContentBloc>().add(ByAnyContentEventRequestEvent(
              //             id: widget.id.toString(),
              //             type:(widget.typeContent==DetailsType.Module)?'module':(widget.typeContent==DetailsType.Subject)?"subject":"chapter",
              //             studentId:context.read<CurrentUserBloc>().userData!.id.toString(),
              //             code:""
              //         ));
              //
              //         if(stateBaying is ByAnyContentRequestState && stateBaying.requestState ==RequestState.loading){
              //           showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"Waiting...",),);
              //         }
              //         if(stateBaying is ByAnyContentRequestState && stateBaying.requestState ==RequestState.error){
              //           showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"Insufficient funds",),);
              //           Navigator.pop(context);
              //         }
              //         if(stateBaying is ByAnyContentRequestState && stateBaying.requestState ==RequestState.done){
              //           showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"Purchased successfully"),);
              //           Navigator.pop(context);
              //
              //         }
              //
              //       },
              //       text: "Bay it Using wallet",
              //       elevation: 1,
              //       textStyle: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s12),
              //       heightButton: AppConstants.hScreen(context)*0.06,
              //     );
              //   }
              // ),

              SizedBox(height: AppPadding.pVScreen1(context),),
              CustomButton(
                onPressed: ()async{
                  await typePurchaseSheetController.reverse();
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      id: widget.id,
                      typeContent: (widget.typeContent==DetailsType.Subject)?"subject":"module",
                      isChargeWallet: false,
                      amount: widget.price,
                      title: "${widget.title}",
                      description: "Enter the code from a scratch card to buy the Model",
                    ),
                  );
                },
                text: "get it Using code",
                elevation: 1,
                textStyle: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s12),
                heightButton: AppConstants.hScreen(context)*0.06,
              ),
              SizedBox(height: AppPadding.pVScreen1(context),),

              BlocBuilder<RequestContentBloc,RequestContentState>(
                  builder: (context,stateRequestBaying) {
                  return CustomButton(
                    onPressed: ()async{
                      context.read<RequestContentBloc>().add(RequestContentEventRequestEvent(
                          id:widget.id.toString(),
                          type:(widget.typeContent==DetailsType.Module)?'module':(widget.typeContent==DetailsType.Subject)?"subject":"chapter",
                          studentId:context.read<CurrentUserBloc>().userData!.id.toString(),
                      ));

                      if(stateRequestBaying is RequestContentRequestState && stateRequestBaying.requestState ==RequestState.loading){
                        showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"Waiting...",),);

                      }

                      if(stateRequestBaying is RequestContentRequestState && stateRequestBaying.requestState ==RequestState.error){
                        showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"${stateRequestBaying.responseMessage}",),);

                      }
                      if(stateRequestBaying is RequestContentRequestState && stateRequestBaying.requestState ==RequestState.done){
                        showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"${stateRequestBaying.responseMessage}"),);
                      }
                    },
                    text: "Request it",
                    elevation: 1,
                    backgroundColor: ColorManager.darkGrey.withOpacity(0.6),
                    textStyle: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s12),
                    heightButton: AppConstants.hScreen(context)*0.06,
                  );
                }
              ),
              SizedBox(height: AppPadding.pVScreen4(context),),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isTextBottom==true){
      return TextButton(
        onPressed: (){
          _typePurchaseSheet(context);
        },
        child: Column(
          children: [
            Text(
              "Get ${(widget.typeContent==DetailsType.Module)?"Module":(widget.typeContent==DetailsType.Chapter)?"Chapter":"Subject"}",
              style: getBoldStyle(
                  color: ColorManager.primary,fontSize: FontSize.s10),
            ),

          ],
        ),

      );
    }else {
      return CustomButton(
        onPressed: (){
          _typePurchaseSheet(context);
        },
        text: "Get ${(widget.typeContent==DetailsType.Module)?"Module":(widget.typeContent==DetailsType.Chapter)?"Chapter":"Subject"}",
        elevation: 2,
        heightButton: AppConstants.hScreen(context)*0.06,
        textStyle: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s12),
      );
    }
  }
}