import 'package:falcon/core/core_exports.dart';

class LastChapters extends StatelessWidget {
  const LastChapters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataBloc,GetHomeDataState>(
        buildWhen: (previous, current) =>
        previous.getLastChaptersRequestState != current.getLastChaptersRequestState,
      builder: (context , chaptersResponseState) {
        if(chaptersResponseState.getLastChaptersRequestState ==RequestState.loading){
          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "latest Chapters",
                      style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                    ),
                    Skeletonizer(child: Text("-------" )),
                  ],
                ),
              ),
              SizedBox(height: AppConstants.hScreen(context)*0.01,),
              Skeletonizer(
                child:SizedBox(
                  height: AppConstants.hScreen(context)*0.26,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    padding: EdgeInsets.only(left: AppPadding.pHScreen2(context)),
                    itemBuilder: (context,index){
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen1(context)),
                        child: CustomChapterItemHorizontal(lastChapter:LastChapterEntity(id:"",name:"------------------" ,course:"----------",subjectName:"----------", img:"" ,description: "--------------------------------------------------"  ),),

                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        else if(chaptersResponseState.getLastChaptersRequestState ==RequestState.done ){
          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "latest Chapters",
                      style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                    ),
                    Text(
                      "",
                      style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppConstants.hScreen(context)*0.02,),
              SizedBox(
                height: AppConstants.hScreen(context)*0.26,
                child: (chaptersResponseState.lastChaptersResponse.isNotEmpty)?ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: chaptersResponseState.lastChaptersResponse.length,
                  padding: EdgeInsets.only(left: AppPadding.pHScreen2(context)),
                  itemBuilder: (context,index){
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen1(context)),
                      child: GestureDetector(
                        onTap: ()async{
                          bool canPayment = (await CacheHelper.getData(key:"canPayment")=="true")?true:false;;
                          Navigator.push(context, PageTransition(
                            child: DetailsView(
                              canPayment: canPayment,
                              isMyLearning: false,
                              type: DetailsType.LastChapter,
                              imageUrl: chaptersResponseState.lastChaptersResponse[index].img,
                              lastChapter: chaptersResponseState.lastChaptersResponse[index],
                            ),
                            type: PageTransitionType.fade,
                            curve: Curves.fastEaseInToSlowEaseOut,
                            duration: const Duration(milliseconds: AppConstants.pageTransition200),
                          ));
                        },
                        child: CustomChapterItemHorizontal(lastChapter: chaptersResponseState.lastChaptersResponse[index],),
                      ),

                    );
                  },
                )
                :CustomEmptyComponent(
                  emptyItemType: "chapter",
                  heightScreen: AppConstants.hScreen(context)*0.18,
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
              context.read<GetHomeDataBloc>().add(GetLastChaptersEvent());
            },
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "latest Chapters",
                        style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                      ),
                      Skeletonizer(child: Text("-------" )),
                    ],
                  ),
                ),
                SizedBox(height: AppConstants.hScreen(context)*0.01,),
                Container(
                  width: double.infinity,
                  height: AppConstants.hScreen(context)*0.22,
                  margin: EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
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
                        chaptersResponseState.getLastChaptersMessage,
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