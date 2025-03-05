import 'package:falcon/core/core_exports.dart';

class ModuleContentViews extends StatelessWidget {
  const ModuleContentViews({
    super.key,
    required this.module,
    required this.isMyLearning,
    required this.canPayment,
  });
  final ModuleEntity module;
  final bool isMyLearning;
  final bool canPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        context: context,
        title: module.name,
        hasArrowBack: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppPadding.pVScreen1(context),),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context),),
            child: Text(
              "${module.description}",
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
                  "# All Subjects",
                  style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                ),
                  (canPayment)?
                  (isMyLearning==false)?GetContentBottom(
                  typeContent:DetailsType.Module ,
                  title: module.name,
                  id: module.id,
                  price: double.parse(module.price),
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
                    offset:Offset(0,0.5),
                    blurRadius: 2,
                    spreadRadius: 1
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocProvider(
              create: (BuildContext context)=> GetSubjectsBloc(getUserSubjectsUsecase: sl<GetUserSubjectsUsecase>())
                ..add(GetSubjectsRequestEvent(moduleId:int.parse(module.id))),//todo module.id
              child: BlocBuilder<GetSubjectsBloc,GetSubjectsState>(
                  builder: (context , subjectsResponseState) {
                    if(subjectsResponseState.requestState ==RequestState.loading){
                      return Skeletonizer(
                        child: ListView.separated(
                          itemCount: 10,
                          padding: EdgeInsets.symmetric(
                            horizontal:AppPadding.pHScreen4(context),
                            vertical:AppPadding.pVScreen2(context),
                          ),
                          separatorBuilder: (context, index) => Divider(color: ColorManager.lightGrey,thickness: 1,),
                          itemBuilder: (context,index){
                            return SubjectOfModuleItem(isMyLearning: isMyLearning,subject:SubjectEntity(id:"", image: "", imageUrl: "", name: "---------------------------", price: "----", doctors: [], chapters: [], description: "---------------------------"),);
                          },
                        ),
                      );
                    }else if(subjectsResponseState.requestState ==RequestState.done){

                      return (subjectsResponseState.subjectsResponse.isNotEmpty)?ListView.separated(
                        itemCount:subjectsResponseState.subjectsResponse.length,
                        padding: EdgeInsets.symmetric(
                          horizontal:AppPadding.pHScreen4(context),
                          vertical:AppPadding.pVScreen2(context),
                        ),
                        separatorBuilder: (context, index) => Divider(color: ColorManager.lightGrey,thickness: 1,),
                        itemBuilder: (context,index){
                          return SubjectOfModuleItem(isMyLearning: isMyLearning,subject: subjectsResponseState.subjectsResponse[index],);
                        },
                      ):CustomEmptyComponent(emptyItemType: "subject");
                    }
                    else{
                      return GestureDetector(
                        onTap: (){
                          context.read<GetSubjectsBloc>().add(GetSubjectsRequestEvent(moduleId:int.parse(module.id)));
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
                                "Make sure you are enrolled in this module, and try again.",
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

class SubjectOfModuleItem extends StatelessWidget {
  const SubjectOfModuleItem({
    super.key,
    required  this.subject,
    required  this.isMyLearning
  });

  final SubjectEntity subject ;
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

              bool canPayment =(await CacheHelper.getData(key:"canPayment")=="true")?true:false;
              Navigator.push(context, PageTransition(
                child: DetailsView(
                  isMyLearning: isMyLearning,
                  type: DetailsType.Subject,
                  imageUrl: subject.imageUrl,
                  subject: subject,
                  canPayment: canPayment,
                ),
                type: PageTransitionType.fade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: AppConstants.pageTransition200),
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left:Radius.circular(AppRadius.r10)),
              child:CachedNetworkImage(
                imageUrl:subject.imageUrl!,
                height: AppConstants.hScreen(context)*0.14,
                width: AppConstants.wScreen(context)*0.35,
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
                  height: AppConstants.hScreen(context)*0.14,
                  width: AppConstants.wScreen(context)*0.35,
                  fit: BoxFit.fill,
                ),

              ),
            ),
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(AppRadius.r8),
            //   child: SizedBox(
            //     height: AppConstants.hScreen(context)*0.14,
            //     width: AppConstants.wScreen(context)*0.35,
            //     child: Image.asset(
            //       AssetsManager.subjectIcon,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: ()async{
                bool canPayment = await fetchPaymentState();
                Navigator.push(context, PageTransition(
                  child: SubjectContentViews(
                    isMyLearning: isMyLearning,
                    canPayment: canPayment,
                    subject: subject,
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));

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
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal:AppPadding.pHScreen4(context),
                  vertical:AppPadding.pVScreen06(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${subject.name}",
                      style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s10),
                    ),
                    SizedBox(height: AppPadding.pVScreen06(context),),
                    Text(
                      "${subject.description}",
                      style: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                    ),
                    SizedBox(height: AppPadding.pVScreen06(context),),
                    Row(
                      mainAxisAlignment: (subject.chapters?.length)!=0?MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
                      children: [
                        Text(
                          "${(subject.chapters?.length)==0?"":"${subject.chapters?.length}  Chapters"}",
                          style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                        ),
                        Text(
                          "${subject.price}",//E£
                          style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                        ),
                      ],
                    ),
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
