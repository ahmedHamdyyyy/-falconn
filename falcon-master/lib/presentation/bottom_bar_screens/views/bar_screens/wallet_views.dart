import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValidateCodeChargeBloc,ValidateCodeChargeState>(
      listener:(context ,walletCharge) {
        if(walletCharge is ValidateCodeChargeRequestState && walletCharge.requestState==RequestState.loading){
          showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"Waiting...",),);
        }
        if(walletCharge is ValidateCodeChargeRequestState && walletCharge.requestState==RequestState.done){
          showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"wallet successfully charged",),);
        }
        if(walletCharge is ValidateCodeChargeRequestState && walletCharge.requestState==RequestState.error){
          showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"Code not valid",),);
        }
      },
      builder: (context ,walletCharge) {
        return Scaffold(
          appBar: CustomAppBar(
            elevation: 0,
            context: context,
            title: "All Modules",
            hasArrowBack: true,
          ),
          body: BlocProvider(
            create: (BuildContext context)=> GetWalletAmountBloc(showWalletUsecase: sl<ShowWalletUsecase>())
              ..add(GetWalletAmountRequestEvent(
                userId:int.parse(context.read<CurrentUserBloc>().userData!.id),
              )),
            child: BlocBuilder<GetWalletAmountBloc,GetWalletAmountState>(
                builder: (context , walletResponseState) {
                if(walletResponseState.requestState ==RequestState.loading){
                  return Skeletonizer(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal: AppPadding.pHScreen6(context),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height:AppPadding.pVScreen4(context),
                          ),
                          Container(
                            width: AppConstants.wScreen(context),
                            height: AppConstants.hScreen(context)*0.2,
                            decoration: BoxDecoration(
                                color: ColorManager.lightGrey,
                                borderRadius: BorderRadius.circular(AppRadius.r8),
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorManager.grey,
                                      offset:Offset(1,2),
                                      blurRadius: 2,
                                      spreadRadius: 1
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                "8920.00",//E£
                                style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:AppConstants.hScreen(context)*0.1,
                          ),
                          CustomButton(
                            onPressed: (){},
                            elevation: 4,
                            text: "Top Up Wallet",
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else if (walletResponseState.requestState ==RequestState.done){
                  return Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: AppPadding.pHScreen6(context),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height:AppPadding.pVScreen4(context),
                        ),
                        Container(
                          width: AppConstants.wScreen(context),
                          height: AppConstants.hScreen(context)*0.2,
                          decoration: BoxDecoration(
                              color: ColorManager.lightGrey,
                              borderRadius: BorderRadius.circular(AppRadius.r8),
                              boxShadow: [
                                BoxShadow(
                                    color: ColorManager.grey,
                                    offset:Offset(1,2),
                                    blurRadius: 2,
                                    spreadRadius: 1
                                ),
                              ]
                          ),
                          child: Center(
                            child: Text(
                              "${walletResponseState.walletEntity?.totalMoney} ",//E£
                              style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:AppConstants.hScreen(context)*0.1,
                        ),
                        CustomButton(
                          onPressed:(){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(
                                id: "1",
                                typeContent: "",
                                amount: 3,
                                title: "To Up Wallet",
                                description: "Enter the code from a scratch card to buy the Model",
                                isChargeWallet: true,
                              ),
                            );
                          },
                          elevation: 4,
                          text: "Top Up Wallet",
                        ),
                      ],
                    ),
                  );
                }
                else {
                  return GestureDetector(
                    onTap: (){
                      context.read<GetWalletAmountBloc>().add(GetWalletAmountRequestEvent(userId: int.parse(context.read<CurrentUserBloc>().userData!.id)));
                    },
                    child: Container(
                      width: AppConstants.wScreen(context),
                      height: AppConstants.hScreen(context),
                      margin: EdgeInsets.symmetric(
                        horizontal: AppPadding.pHScreen4(context),
                        vertical: AppPadding.pVScreen2(context),
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetsManager.warningImage,
                            height: AppConstants.hScreen(context)*0.05,
                            color: ColorManager.darkGrey.withOpacity(0.6),
                          ),
                          SizedBox(height: AppPadding.pVScreen1(context),),
                          Text(
                            walletResponseState.responseMessage,
                            style: getMediumStyle(color: ColorManager.darkGrey),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppPadding.pVScreen1(context),),
                          Icon(
                            Icons.refresh,
                            color: ColorManager.darkGrey,
                            size: AppSize.s20,

                          ),

                        ],
                      ),
                    ),
                  );
                }
              }
            ),
          ),
        );
      }
    );
  }
}
