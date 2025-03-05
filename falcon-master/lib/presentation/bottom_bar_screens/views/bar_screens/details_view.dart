import 'package:falcon/core/core_exports.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    super.key,
    required this.type,
    required this.imageUrl,
    required this.isMyLearning,
    this.module,
    this.subject,
    this.chapter,
    this.lastChapter,
    required this.canPayment,

  });

  final DetailsType type;
  final String? imageUrl;
  final bool isMyLearning;
  final ModuleEntity? module;
  final SubjectEntity? subject;
  final ChapterEntity? chapter;
  final LastChapterEntity? lastChapter;
  final bool canPayment;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<EvaluateSubjectCubit>(
      create: (_) => EvaluateSubjectCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          elevation: 0,
          context: context,
          title: (type== DetailsType.Module && module!=null) ? module!.name
              :(type== DetailsType.Subject&& subject!=null)? subject!.name
              :(type== DetailsType.Chapter&& chapter!=null)? chapter!.name
              :(type== DetailsType.LastChapter&& lastChapter!=null)? lastChapter!.name:"",
          hasArrowBack: true,
        ),
        body: (type ==DetailsType.Subject && subject !=null && subject!.doctors !=null)?SingleChildScrollView(
          child: _Body0fDetails(canPayment:canPayment,type: type, module: module, subject: subject, imageUrl: imageUrl, chapter: chapter, lastChapter: lastChapter,isMyLearning:isMyLearning),
        ):_Body0fDetails(canPayment:canPayment,type: type, module: module, subject: subject, imageUrl: imageUrl, chapter: chapter, lastChapter: lastChapter,isMyLearning:isMyLearning),
      ),
    );
  }
}

class _Body0fDetails extends StatelessWidget {
  const _Body0fDetails({
    super.key,
    required this.type,
    required this.isMyLearning,
    required this.module,
    required this.subject,
    required this.imageUrl,
    required this.chapter,
    required this.lastChapter,
    required this.canPayment,
  });

  final DetailsType type;
  final ModuleEntity? module;
  final SubjectEntity? subject;
  final String? imageUrl;
  final bool isMyLearning;
  final ChapterEntity? chapter;
  final LastChapterEntity? lastChapter;
  final bool canPayment;

  @override
  Widget build(BuildContext context) {
    return  Column(
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


            if(type==DetailsType.Module && module!=null){
              bool canPayment = (await CacheHelper.getData(key:"canPayment")=="true")?true:false;;
              Navigator.push(context, PageTransition(
                child: ModuleContentViews(
                  isMyLearning: isMyLearning,
                  module: module!,
                  canPayment: canPayment,
                ),
                type: PageTransitionType.fade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: AppConstants.pageTransition200),
              ));
            }
            if(type==DetailsType.Subject && subject!=null){
              Navigator.push(context, PageTransition(
                child: SubjectContentViews(
                  isMyLearning: isMyLearning,
                  subject: subject!,
                  canPayment: canPayment,
                ),
                type: PageTransitionType.fade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: AppConstants.pageTransition200),
              ));
            }
            if(type==DetailsType.Chapter && isMyLearning==true){
              Navigator.push(context, PageTransition(
                child: BlocProvider(
                  create: (context) => ContentTabBloc(),
                  child: ChaptersContentViews(
                    title: "${chapter?.name}",
                    chapterImage: "${chapter?.imgUrl}",
                    chapterId: int.parse(chapter!.id),
                  ),
                ),
                type: PageTransitionType.fade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: AppConstants.pageTransition200),
              ));
            }

            // if(type==DetailsType.LastChapter && isMyLearning==false){
            //   Navigator.push(context, PageTransition(
            //     child: BlocProvider(
            //       create: (context) => ContentTabBloc(),
            //       child: ChaptersContentViews(
            //         title: "${lastChapter?.name}",
            //         chapterImage: "${lastChapter?.img}",
            //        // chapterId: int.parse(lastChapter!.id), todo change
            //         chapterId: 3,
            //       ),
            //     ),
            //     type: PageTransitionType.fade,
            //     curve: Curves.fastEaseInToSlowEaseOut,
            //     duration: const Duration(milliseconds: AppConstants.pageTransition200),
            //   ));
            // }
          },
          child:CachedNetworkImage(
            imageUrl:imageUrl!,
            width: AppConstants.wScreen(context),
            height: AppConstants.hScreen(context)*0.3,
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
              width: AppConstants.wScreen(context),
              height: AppConstants.hScreen(context)*0.3,
              fit: BoxFit.fill,
            ),

          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: AppPadding.pHScreen4(context),
            vertical: AppPadding.pVScreen2(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen2(context)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
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


                          if(type==DetailsType.Module && module!=null){
                            Navigator.push(context, PageTransition(
                              child: ModuleContentViews(
                                isMyLearning:isMyLearning ,
                                module: module!,
                                canPayment: canPayment,
                              ),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: AppConstants.pageTransition200),
                            ));
                          }
                          if(type==DetailsType.Subject && subject!=null){
                            Navigator.push(context, PageTransition(
                              child: SubjectContentViews(
                                canPayment: canPayment,
                                isMyLearning: isMyLearning,
                                subject: subject!,
                              ),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: AppConstants.pageTransition200),
                            ));
                          }
                          if(type==DetailsType.Chapter  && isMyLearning ==true){
                            Navigator.push(context, PageTransition(
                              child: BlocProvider(
                                create: (context) => ContentTabBloc(),
                                child: ChaptersContentViews(
                                  title: "${chapter?.name}",
                                  chapterImage: "${chapter?.imgUrl}",
                                  chapterId: int.parse(chapter!.id),
                                ),
                              ),
                              type: PageTransitionType.fade,
                              curve: Curves.fastEaseInToSlowEaseOut,
                              duration: const Duration(milliseconds: AppConstants.pageTransition200),
                            ));
                          }
                        },
                        child: Text(
                          (type== DetailsType.Module && module!=null) ? module!.name
                              :(type== DetailsType.Subject&& subject!=null)? subject!.name
                              :(type== DetailsType.Chapter&& chapter!=null)? chapter!.name
                              :(type== DetailsType.LastChapter&& lastChapter!=null)? lastChapter!.name:"",
                          style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                        ),
                      ),
                    ),
                    Text(
                      (type== DetailsType.Module && module!=null) ? module!.price+""//E£
                          :(type== DetailsType.Subject&& subject!=null)? subject!.price+""//E£
                          :"",
                      style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                    ),
                  ],
                ),
              ),

              //---------------------------------------
              (type==DetailsType.Chapter &&chapter!=null && chapter!.course!=null && chapter!.course!="")?SizedBox(
                height: AppPadding.pVScreen1(context),
              ):SizedBox(),
              (type==DetailsType.Chapter &&chapter!=null && chapter!.course!=null && chapter!.course!="")?Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen2(context)),
                child: Text(
                  "${chapter!.course}",
                  style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                ),
              ):SizedBox(),

              //---------------------------------------
              (type==DetailsType.LastChapter &&lastChapter!=null && lastChapter!.course!="")?SizedBox(
                height: AppPadding.pVScreen1(context),
              ):SizedBox(),
              (type==DetailsType.LastChapter &&lastChapter!=null && lastChapter!.course!="")?Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen2(context)),
                child: Text(
                  "${lastChapter!.course}",
                  style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                ),
              ):SizedBox(),

              //---------------------------------------
              SizedBox(
                height: AppPadding.pVScreen1(context),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen2(context)),
                child: Text(
                  "${(type== DetailsType.Module && module!=null) ? module!.description
                      :(type== DetailsType.Subject&& subject!=null)? subject!.description
                      :(type== DetailsType.Chapter&& chapter!=null)? chapter!.description
                      :(type== DetailsType.LastChapter&& lastChapter!=null)? lastChapter!.description:"" }",
                  style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
                ),
              ),


              //---------------------------------------
              (type == DetailsType.Module && module !=null)?SizedBox(
                height: AppPadding.pVScreen1(context),
              ):SizedBox(),
              (type == DetailsType.Module && module !=null)
                  ?_ItemDetails(icon: Icons.access_time_rounded,firstText: "Start on ",secondText: module!.startDate,)
                  :SizedBox(),

              //---------------------------------------
              (type == DetailsType.Module && module !=null)?SizedBox(
                height: AppPadding.pVScreen1(context),
              ):SizedBox(),
              (type == DetailsType.Module && module !=null)
                  ?_ItemDetails(icon: Icons.access_time_rounded,firstText: "End on ",secondText: module!.endDate,)
                  :SizedBox(),

              //---------------------------------------

              SizedBox(
                height: AppPadding.pVScreen04(context),
              ),




            ],
          ),
        ),


        ( type ==DetailsType.Subject && subject !=null && subject!.doctors !=null)?SizedBox(
          height:AppConstants.hScreen(context)*0.00,
        ):(isMyLearning==true &&  type !=DetailsType.Subject )
            ? SizedBox(height: AppConstants.hScreen(context)*0.28)
            :SizedBox(height: AppConstants.hScreen(context)*0.18),

        (type== DetailsType.Chapter && isMyLearning==false)? SizedBox(height: AppConstants.hScreen(context)*0.1):SizedBox(),

        ( (type!= DetailsType.LastChapter&& type!= DetailsType.Chapter) || (type == DetailsType.Chapter && isMyLearning==true) )?Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)).copyWith(bottom: AppPadding.pVScreen2(context),),
          child: CustomButton(
            backgroundColor: ColorManager.lightGrey,
            textStyle: getBoldStyle(color: ColorManager.primary),
            onPressed: ()async{
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

              if(type==DetailsType.Module && module!=null){
                Navigator.push(context, PageTransition(
                  child: ModuleContentViews(
                    canPayment: canPayment,
                    isMyLearning: isMyLearning,
                    module: module!,
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              }
              if(type==DetailsType.Subject && subject!=null){
                Navigator.push(context, PageTransition(
                  child: SubjectContentViews(
                    canPayment: canPayment,
                    isMyLearning: isMyLearning,
                    subject: subject!,
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              }
              if(type==DetailsType.Chapter && isMyLearning==true){
                Navigator.push(context, PageTransition(
                  child: BlocProvider(
                    create: (context) => ContentTabBloc(),
                    child: ChaptersContentViews(
                      title: "${chapter?.name}",
                      chapterId: int.parse(chapter!.id),
                      chapterImage: "${chapter?.imgUrl}",
                    ),
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Show ${(type==DetailsType.Module)?"Subjects":(type==DetailsType.Subject)?"Chapters":(type==DetailsType.Chapter)?"All Content":""} ",
                  style: getBoldStyle(color: ColorManager.primary),
                ),
                Icon(Icons.arrow_forward_ios_rounded,color: ColorManager.primary,size: AppSize.s30,),
              ],
            ),

          ),
        ):SizedBox(),
        ( canPayment)?
        (isMyLearning==false && type!= DetailsType.Chapter && type!= DetailsType.LastChapter)?Padding(
          padding:  EdgeInsets.only(
            left: AppPadding.pHScreen6(context),
            right: AppPadding.pHScreen6(context),
            bottom: AppPadding.pVScreen4(context),
            top: AppPadding.pVScreen2(context),
          ),
          child: GetContentBottom(
            typeContent: type,
            id: type ==DetailsType.Module?module!.id:subject!.id,
            title: "Choose how to get the ${(type==DetailsType.Module)?"Module":(type==DetailsType.Chapter)?"Chapter":"Subject"}",
            price: double.parse((type== DetailsType.Module && module!=null) ? module!.price
                :(type== DetailsType.Subject&& subject!=null)? subject!.price
                :"0"),
          ),
        ):SizedBox():SizedBox(),


        (type ==DetailsType.Subject && subject !=null)?Padding(
          padding:  EdgeInsets.symmetric(horizontal:AppPadding.pHScreen4(context) ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<EvaluateSubjectCubit, EvaluateSubjectState>(
                    builder: (context, state) {
                      return RatingBar.builder(
                        initialRating: state.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: AppSize.s28,
                        unratedColor: ColorManager.darkGrey.withOpacity(0.4),
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          context.read<EvaluateSubjectCubit>().updateRating(rating);
                        },
                      );
                    },
                  ),
                  BlocBuilder<RateAndCommentBloc,RateAndCommentState>(
                      builder: (context,rateResponse) {
                        if(rateResponse is RateAndCommentLoadingState){
                          return Container(
                            width: AppPadding.pHScreen6(context),
                            height: AppPadding.pHScreen6(context),
                            margin: EdgeInsets.only(right: AppPadding.pHScreen1(context)),
                            child: CircularProgressIndicator(),
                          );
                        }else {
                          return TextButton(
                            onPressed: (){
                              context.read<EvaluateSubjectCubit>().submitEvaluation(context:context,subjectId: subject!.id);
                            },
                            child: Row(
                              children: [
                                (rateResponse.requestState == RequestState.done)?Icon(Icons.check,color: ColorManager.primary,size: AppSize.s20,):(rateResponse.requestState == RequestState.error)?Icon(Icons.close,color: ColorManager.error,size: AppSize.s20,):SizedBox(),
                                (rateResponse.requestState == RequestState.done || rateResponse.requestState == RequestState.error )?SizedBox(width: AppPadding.pHScreen2(context),):SizedBox(),
                                Text(
                                  "Send",
                                  style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                                ),
                              ],
                            ),

                          );
                        }
                      }
                  ),
                ],
              ),
              SizedBox(height: AppPadding.pVScreen08(context),),
              BlocBuilder<EvaluateSubjectCubit, EvaluateSubjectState>(
                builder: (context, state) {
                  return CustomTextFormField(
                    hintText: "Write comment",
                    maxLines: 3,
                    heightFilled: AppConstants.hScreen(context)*0.12,
                    hintStyle: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s12),
                    textStyle: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s12),
                    onChanged: (comment) {
                      context.read<EvaluateSubjectCubit>().updateComment(comment);
                    },
                  );
                },
              ),
            ],
          ),
        ):SizedBox(),

        // RatingBar controlled by Bloc


        (type ==DetailsType.Subject && subject !=null && subject!.doctors !=null)?Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.pHScreen6(context)).copyWith(top:AppPadding.pVScreen1_5(context)),
          child: Text(
            "# Doctors",
            style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
          ),
        ):SizedBox(),
        (type ==DetailsType.Subject && subject !=null && subject!.doctors !=null)?SizedBox(
          height: AppPadding.pVScreen1(context),
        ):SizedBox(),
        (type ==DetailsType.Subject && subject !=null && subject!.doctors !=null)
            ?Container(
          padding:  EdgeInsets.only(
            left: AppPadding.pHScreen4(context),
            right: AppPadding.pHScreen4(context),
            bottom: AppPadding.pVScreen2(context),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:subject!.doctors!.length ,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0 ),
            itemBuilder: (context,index){
              return CustomDoctorSubject(doctor: subject!.doctors![0],);
            },
          ),
        )
            :SizedBox(),
      ],
    );
  }


}


class _ItemDetails extends StatelessWidget {
  const _ItemDetails({
    super.key,
    required this.icon,
    required this.secondText,
    this.firstText,
    this.fontSize,
    this.iconColor,
    this.firstTextColor,
    this.secondTextColor,
    this.firstTextBold,
    this.secondTextBold,
  });

  final String? firstText;
  final String secondText;
  final IconData icon;
  final double? fontSize ;
  final Color? iconColor;
  final Color? firstTextColor;
  final Color? secondTextColor;
  final bool? firstTextBold;
  final bool? secondTextBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,size:AppSize.s20,color: iconColor??ColorManager.primary,),
        SizedBox(
          width: AppPadding.pHScreen1(context),
        ),
        (firstText!=null)?Text(
          firstText!,
          style: (firstTextBold==false)
              ?getMediumStyle(color:firstTextColor?? ColorManager.black.withOpacity(0.9),fontSize:fontSize?? FontSize.s10)
              :getBoldStyle(color:firstTextColor?? ColorManager.black.withOpacity(0.9),fontSize:fontSize?? FontSize.s10),
        ):SizedBox(),
        SizedBox(
          width:(firstText!=null)?AppPadding.pHScreen1(context):0,
        ),
        Text(
          "$secondText",
          style: (secondTextBold==false)
              ?getMediumStyle(color: secondTextColor?? ColorManager.darkGrey.withOpacity(0.9),fontSize:fontSize?? FontSize.s10,)
              :getBoldStyle(color: secondTextColor?? ColorManager.darkGrey.withOpacity(0.9),fontSize:fontSize?? FontSize.s10,),
        ),
      ],
    );
  }
}

class CustomDoctorSubject extends StatelessWidget {
  const CustomDoctorSubject({
    super.key,
    required this.doctor,
  });
  final DoctorEntity doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppConstants.wScreen(context),
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pHScreen2(context),
          vertical: AppPadding.pVScreen1(context),
        ).copyWith(bottom: AppPadding.pVScreen08(context),),
        margin: EdgeInsets.symmetric(
          horizontal: AppPadding.pHScreen2(context),
          vertical: AppPadding.pVScreen1(context),
        ).copyWith(bottom: AppPadding.pVScreen08(context),),
        decoration: BoxDecoration(
          color: ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(AppRadius.r10,),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dr: ${doctor.name}",
                  style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s12),
                ),
                Text(
                  (doctor.phone==null)?"no phone":(doctor.phone=="")?"no phone":"${doctor.phone}",
                  style: getMediumStyle(color: ColorManager.primary,fontSize: FontSize.s10),
                ),
              ],
            ),
            SizedBox(height: AppPadding.pVScreen06(context),),
            Text(
              (doctor.description==null)?"no description":(doctor.description=="")?"no description":"${doctor.description}",
              textAlign: TextAlign.start,
              style: getMediumStyle(color: ColorManager.textGrey,fontSize: FontSize.s10),
            ),
          ],
        )
    );
  }
}