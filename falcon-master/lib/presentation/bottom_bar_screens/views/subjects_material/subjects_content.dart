import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SubjectContentViews extends StatelessWidget {
  const SubjectContentViews({
    super.key,
    required this.subject,
    required this.isMyLearning,
    required this.canPayment,

  });
  final SubjectEntity subject ;
  final bool isMyLearning ;
  final bool canPayment ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        context: context,
        title: subject.name,
        hasArrowBack: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppPadding.pVScreen1(context),),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context),),
            child: Text(
              "${subject.description}",
              overflow: TextOverflow.ellipsis,
              style: getBoldStyle(color: ColorManager.textGrey,fontSize: 10),
            ),
          ),
          SizedBox(height: AppPadding.pVScreen1(context),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:AppPadding.pHScreen4(context),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# All Chapters",
                  style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                ),
                (canPayment)?
                (isMyLearning==false)?GetContentBottom(
                  typeContent:DetailsType.Subject ,
                  title: subject.name,
                  id: subject.id,
                  price: double.parse(subject.price),
                  isTextBottom: true,
                ):SizedBox():SizedBox(),
              ],
            ),
          ),
          SizedBox(height: AppPadding.pVScreen1(context),),
          Container(
            height: 1.6,
            width: AppConstants.wScreen(context),
            decoration: BoxDecoration(
              color: ColorManager.lightGrey,
              boxShadow: [
                BoxShadow(
                    color: ColorManager.lightGrey,
                    offset:Offset(0.5,0.5),
                    blurRadius: 2,
                    spreadRadius: 1
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocProvider(
              create: (BuildContext context)=> GetChaptersBloc(getUserChaptersUsecase: sl<GetUserChaptersUsecase>())
                ..add(GetChaptersRequestEvent(
                    subjectId:int.parse(subject.id),
                    userId:int.parse(context.read<CurrentUserBloc>().userData!.id),
                )),
              child: BlocBuilder<GetChaptersBloc,GetChaptersState>(
                  builder: (context , chapterResponseState) {
                  if(chapterResponseState.requestState ==RequestState.loading){
                    return Skeletonizer(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(color: ColorManager.lightGrey,thickness: 1,),
                        itemCount: 10,
                        padding: EdgeInsets.symmetric(
                          horizontal:AppPadding.pHScreen4(context),
                          vertical:AppPadding.pVScreen2(context),
                        ),
                        itemBuilder: (context,index){
                          return ChapterOfModuleItem(isMyLearning:isMyLearning,chapter:ChapterEntity(id:"", img: "", imgUrl: "", name: "---------------------------",course:"",subjectId: "" ,description: "---------------------------"),);
                        },
                      ),
                    );
                  }else if (chapterResponseState.requestState ==RequestState.done){
                    return (chapterResponseState.ChaptersResponse.isNotEmpty)?ListView.separated(
                      separatorBuilder: (context, index) => Divider(color: ColorManager.lightGrey,thickness: 1,),
                      itemCount:  chapterResponseState.ChaptersResponse.length,
                      padding: EdgeInsets.symmetric(
                        horizontal:AppPadding.pHScreen4(context),
                        vertical:AppPadding.pVScreen2(context),
                      ),
                      itemBuilder: (context,index){
                        return ChapterOfModuleItem(isMyLearning:isMyLearning,chapter: chapterResponseState.ChaptersResponse[index]);
                      },
                    ):CustomEmptyComponent(emptyItemType: "chapter");
                  }
                  else {
                    return GestureDetector(
                      onTap: (){
                        context.read<GetChaptersBloc>().add(GetChaptersRequestEvent(
                        subjectId:int.parse(subject.id),
                        userId:int.parse(context.read<CurrentUserBloc>().userData!.id),
                        ));
                      },
                      child: Container(
                        width: AppConstants.wScreen(context),
                        height: AppConstants.hScreen(context)*0.7,
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
                              "assets/images/png/enrolled.png",
                              height: AppConstants.hScreen(context)*0.14,
                            ),
                            SizedBox(height: AppPadding.pVScreen4(context),),
                            Text(
                              "Make sure you are enrolled in this subject, and try again.",
                              style: getBoldStyle(color: ColorManager.primary),
                              textAlign: TextAlign.center,
                            ),
                            // SizedBox(height: AppPadding.pVScreen2(context),),
                            // Icon(
                            //   Icons.refresh,
                            //   color: ColorManager.primary,
                            //   size: AppSize.s20,
                            // ),

                          ],
                        ),
                      ),
                    );
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChapterOfModuleItem extends StatelessWidget {
  const ChapterOfModuleItem({
    super.key,
    required this.chapter,
    required this.isMyLearning,
  });

  final ChapterEntity chapter;
  final bool isMyLearning;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.yellow.shade200,
      margin: EdgeInsets.only(
        bottom:AppPadding.pHScreen1(context),
        top:AppPadding.pHScreen1(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: ()async{
              UsbConnectionChecker usbChecker = UsbConnectionChecker();
              bool isConnected = await usbChecker.isUsbConnected();
              if (isConnected) {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      child: DeveloperModeScreen(isEmulator: false, isUsbConnect: isConnected,isDeveloperMode:false),
                      type: PageTransitionType.fade,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: const Duration(milliseconds: AppConstants.pageTransition200),
                    ), (Route<dynamic> route) => false
                );
              }
              bool canPayment = (await CacheHelper.getData(key:"canPayment")=="true")?true:false;;
              Navigator.push(context, PageTransition(
                child: DetailsView(
                  isMyLearning: isMyLearning,
                  type: DetailsType.Chapter,
                  imageUrl: chapter.imgUrl,
                  chapter: chapter,
                  canPayment: canPayment,
                ),
                type: PageTransitionType.fade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: AppConstants.pageTransition200),
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              child:SizedBox(
                height: AppConstants.hScreen(context)*0.12,
                width: AppConstants.wScreen(context)*0.32,
                child: CachedNetworkImage(
                  imageUrl:chapter.imgUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Skeletonizer(
                    child: Container(
                      color: ColorManager.lightGrey,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AssetsManager.defaultImage,
                    fit: BoxFit.fill,
                  ),

                ),
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: ()async{
                if(isMyLearning){
                  Navigator.push(context, PageTransition(
                    child: BlocProvider(
                      create: (context) => ContentTabBloc(),
                      child: ChaptersContentViews(
                        title: "${chapter.name}",
                        chapterImage: "${chapter.imgUrl}",
                        chapterId: int.parse(chapter.id),
                      ),
                    ),
                    type: PageTransitionType.fade,
                    curve: Curves.fastEaseInToSlowEaseOut,
                    duration: const Duration(milliseconds: AppConstants.pageTransition200),
                  ));
                }else{
                  showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"Make sure you are enrolled in this chapter, and try again.",),);
                }

                UsbConnectionChecker usbChecker = UsbConnectionChecker();
                bool isConnected = await usbChecker.isUsbConnected();
                if (isConnected) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        child: DeveloperModeScreen(isEmulator: false, isUsbConnect: isConnected,isDeveloperMode:false),
                        type: PageTransitionType.fade,
                        curve: Curves.fastEaseInToSlowEaseOut,
                        duration: const Duration(milliseconds: AppConstants.pageTransition200),
                      ), (Route<dynamic> route) => false
                  );
                }

              },
              child: Container(
                color: Colors.white,
                height: AppConstants.hScreen(context)*0.14,
                width: AppConstants.wScreen(context),
                padding:  EdgeInsets.symmetric(
                  horizontal:AppPadding.pHScreen4(context),
                  vertical:AppPadding.pVScreen1(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${chapter.name}",
                      style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                    ),
                    (chapter.course!=null || chapter.course!="")?SizedBox(height: AppPadding.pVScreen04(context),):SizedBox(),
                    Text(
                      "${chapter.course}",
                      style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s9),
                    ),
                      (chapter.description!=null || chapter.description!="")?SizedBox(height: AppPadding.pVScreen04(context),):SizedBox(),
                    (chapter.description!=null || chapter.description!="")?Text(
                      "${chapter.description}",
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                    ):SizedBox(),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
