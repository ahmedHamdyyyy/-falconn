import 'package:falcon/core/core_exports.dart';
import 'package:falcon/core/resources/resources_exports.dart';
class LastModules extends StatelessWidget {
  const LastModules({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataBloc,GetHomeDataState>(
        buildWhen: (previous, current) =>
        previous.getModulesRequestState != current.getModulesRequestState,
        builder: (context , modulesResponseState) {
          if(modulesResponseState.getModulesRequestState ==RequestState.loading){
            return Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Modules",
                        style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                      ),
                      Skeletonizer(
                          child: Text("-------" ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppConstants.hScreen(context)*0.01,),
                Skeletonizer(
                  child: SizedBox(
                    width: AppConstants.hScreen(context),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      padding: EdgeInsets.only(left: AppPadding.pHScreen2(context)),
                      itemBuilder: (context,index){
                        return Padding(
                          padding:  EdgeInsets.symmetric(
                            horizontal: AppPadding.pHScreen4(context),
                            vertical: AppPadding.pVScreen1(context),
                          ),
                          child: CustomModuleItemVertical(module: ModuleEntity(id:"", name: "------------------", image: "", price: "133", startDate: "startDate", endDate: "endDate",imageUrl:"",subjects:[] ,description:"------------------------------------" ),),
                          //child: CustomModuleItemHorizontal(index: index,),
                  
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          else if (modulesResponseState.getModulesRequestState ==RequestState.done){
            return Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Modules",
                        style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, PageTransition(
                            child: AllModules(modules: modulesResponseState.modulesResponse,),
                            type: PageTransitionType.fade,
                            curve: Curves.fastEaseInToSlowEaseOut,
                            duration: const Duration(milliseconds: AppConstants.pageTransition200),
                          ));
                        },
                        child: Text(
                          "See more",
                          style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppConstants.hScreen(context)*0.01,),
                SizedBox(
                  width: AppConstants.hScreen(context),
                  child: (modulesResponseState.modulesResponse.isNotEmpty)?ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: modulesResponseState.modulesResponse.length<=5?modulesResponseState.modulesResponse.length:5,
                    padding: EdgeInsets.only(left: AppPadding.pHScreen2(context)),
                    itemBuilder: (context,index){
                      return Padding(
                        padding:  EdgeInsets.symmetric(
                          horizontal: AppPadding.pHScreen4(context),
                          vertical: AppPadding.pVScreen1(context),
                        ),
                        child:CustomModuleItemVertical(module: modulesResponseState.modulesResponse[index]),
                        //child: CustomModuleItemHorizontal(index: index,),
                      );
                    },
                  )
                      : CustomEmptyComponent(
                    emptyItemType: "module",
                    heightScreen: AppConstants.hScreen(context)*0.2,
                    heightIcon: AppConstants.hScreen(context)*0.06,
                    textFontSize: FontSize.s8,
                  ),
                ),
              ],
            );
          }
          else{
            return GestureDetector(
              onTap: (){
                context.read<GetHomeDataBloc>().add(GetLastModulesEvent(userId: int.parse(context.read<CurrentUserBloc>().userData!.id)));
              },
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Modules",
                          style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                        ),
                        Skeletonizer(child: Text("-------" )),
                      ],
                    ),
                  ),
                  SizedBox(height: AppConstants.hScreen(context)*0.01,),
                  Container(
                    width: double.infinity,
                    height: AppConstants.hScreen(context)*0.18,
                    margin: EdgeInsets.symmetric(
                      horizontal: AppPadding.pHScreen4(context),
                      vertical: AppPadding.pVScreen1(context),
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
                          modulesResponseState.getModulesMessage,
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
                ],
              ),
            );
          }

      }
    );
  }
}
