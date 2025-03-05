import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AllContentItem extends StatelessWidget {
  const AllContentItem({
    super.key,
    required this.items,
    required this.chapterImage,
    required this.chapterTitle,
    required this.chapterId
  });
  final List<ContentEntity>? items ;
  final String chapterImage ;
  final String chapterId ;
  final String chapterTitle ;

  String extractYoutubeId(BuildContext context,String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!; // Return the matched video ID
    } else {
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: AppPadding.pHScreen4(context),
        vertical: AppPadding.pVScreen1(context),
      ),
      child: (items!.isNotEmpty)?ListView.builder(
        itemCount: items?.length,
        padding: EdgeInsets.all(0),
        itemBuilder: (context,index){
          return (items?[index].type=="video" || items?[index].type=="file")?GestureDetector(
            onTap: (){
              if (items?[index].type=="file"){



                Navigator.push(context, PageTransition(
                  child: PdfViewerPage(pdfPath: "${items?[index].file}"),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));

                // print("medhat ${videoFileState.videoFileResponse!.showFiles[0].file}");
                // Navigator.push(context, PageTransition(
                //   child: PdfViewerPage(pdfPath: "${videoFileState.videoFileResponse!.showFiles[0].file}"),
                //   type: PageTransitionType.fade,
                //   curve: Curves.fastEaseInToSlowEaseOut,
                //   duration: const Duration(milliseconds: AppConstants.pageTransition200),
                // ));
              }
              if (items?[index].type=="video"){
                String l = extractYoutubeId(context,items?[index].iframe??"");
                //String l = extractYoutubeId(context, videoFileState.videoFileResponse!.showVideos[index].iframe);
                if(l=="error"){
                  Navigator.push(context, PageTransition(
                    child: ErrorYoutubeLink(),
                    type: PageTransitionType.fade,
                    curve: Curves.fastEaseInToSlowEaseOut,
                    duration: const Duration(milliseconds: 0),
                  ));
                }
                else{
                  Navigator.push(context, PageTransition(
                    child: VideoPlayerScreen(link:"${items?[index].iframe}",),
                    type: PageTransitionType.fade,
                    curve: Curves.fastEaseInToSlowEaseOut,
                    duration: const Duration(milliseconds: AppConstants.pageTransition200),
                  ));

                  /*Navigator.push(context, PageTransition(
                    child: VideoPlayerScreen(link:"${videoFileState.videoFileResponse!.showVideos[index].iframe}",),
                    type: PageTransitionType.fade,
                    curve: Curves.fastEaseInToSlowEaseOut,
                    duration: const Duration(milliseconds: AppConstants.pageTransition200),
                  ));*/
                }
              }
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(
                vertical: AppPadding.pVScreen08(context),
              ),
              child: Container(
                width: AppConstants.wScreen(context),
                height: AppConstants. hScreen(context)*0.1,
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey,
                  borderRadius: BorderRadius.circular(AppRadius.r10,),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: AppPadding.pHScreen6(context)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.r10),
                      child: Container(
                        width: AppConstants.wScreen(context)*0.13,
                        height: AppConstants.hScreen(context)*0.06,
                        decoration: BoxDecoration(
                        ),
                        child: Image.asset(
                          (items?[index].type=="video") ? AssetsManager.videoIcon
                              : AssetsManager.pdfIcon,
                          width: AppConstants.wScreen(context)*0.13,
                          height: AppConstants.hScreen(context)*0.06,
                          fit: BoxFit.cover,

                        ),
                      ),
                    ),
                    SizedBox(width: AppPadding.pHScreen2(context)),
                    Flexible(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                          horizontal: AppPadding.pHScreen2(context),
                          vertical: AppPadding.pVScreen2(context),
                        ),
                        child: Text(
                          "${items?[index].name}",
                          style: getBoldStyle(color: ColorManager.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
              :(items?[index].type=="homework")?GestureDetector(
            onTap: (){
              if(items![index].completed==1){
                showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"You have already completed this quiz",),);
              }
              if(items![index].completed!=1){
                Navigator.push(context, PageTransition(
                  child: BlocProvider(
                    create: (context) => AssignmentBloc(),
                    child: AssignmentBody(chapterTitle: chapterTitle,chapterId: int.parse(chapterId),chapterImage: chapterImage,assignmentId: items![index].id,assignmentName: items![index].name,endDate:items![index].enddate ,),
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              }
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(
                vertical: AppPadding.pVScreen08(context),
              ),
              child: Container(
                width: AppConstants.wScreen(context),
                height: AppConstants. hScreen(context)*0.126,
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey,
                  borderRadius: BorderRadius.circular(AppRadius.r10,
                  ),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: AppPadding.pHScreen4(context),
                    vertical: AppPadding.pVScreen2(context),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        child: SizedBox(
                          height: AppConstants. hScreen(context)*0.082,
                          width: AppConstants.wScreen(context)*0.16,
                          child: Image.asset(
                            AssetsManager.assignmentIcon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: AppPadding.pHScreen2(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${items?[index].name}",
                            style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s12),
                          ),
                          SizedBox(height: AppPadding.pVScreen06(context)),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, size: AppSize.s14,color: ColorManager.darkGrey,),
                              SizedBox(width: AppPadding.pHScreen1(context),),
                              Text(
                                "Valid till ${items![index].enddate}",
                                style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                              ),
                            ],
                          ),
                          SizedBox(height: AppPadding.pVScreen06(context)),
                          Row(
                            children: [
                              Icon(Icons.description_outlined, size:AppSize.s14,color: ColorManager.darkGrey,),
                              SizedBox(width: AppPadding.pHScreen1(context),),
                              Text(
                                "${items![index].numberOfQuestions} Questions",
                                style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (items![index].completed==1)?GestureDetector(
                            onTap: (){
                              context.read<GetAssignmentAnswerBloc>().add(GetAssignmentAnswerRequestEvent(
                                  studentId: context.read<CurrentUserBloc>().userData!.id, quizId: items![index].id));
                              Navigator.push(context, PageTransition(
                                child: AssignmentAnswer(quizId:items![index].id),
                                type: PageTransitionType.fade,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                duration: const Duration(milliseconds: AppConstants.pageTransition200),
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.pHScreen2(context),
                                vertical: AppPadding.pVScreen04(context),
                              ),
                              decoration: BoxDecoration(
                                  color: ColorManager.grey,
                                  borderRadius: BorderRadius.circular(AppRadius.r4)
                              ),
                              child: Text(
                                "Answers",
                                style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s9),
                              ),
                            ),
                          ):SizedBox(),
                          (items![index].completed==1)?SizedBox(height: AppConstants.hScreen(context)*0.03,):SizedBox(height: AppConstants.hScreen(context)*0.06,),
                          Text(
                            (items![index].completed==1)?"Completed":"Not Completed",
                            style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ):GestureDetector(
            onTap: ()async{
              final prefs = await SharedPreferences.getInstance();
              int remainingTime = prefs.getInt('remainingTime') ?? 0; //

              if(items![index].completed==1){
                showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"You have already completed this quiz",),);
              }

              // Load saved time
              if (remainingTime > 0 && items![index].completed!=1) {
                Navigator.push(context, PageTransition(
                  child: QuizBody(chapterTitle: chapterTitle,chapterId: int.parse(chapterId),quizId: int.parse(items![index].id),quizTimer: items![index].timer ,chapterImage: chapterImage,name: items![index].name,),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              }
              else{
                BlocProvider.of<TimerBloc>(context).add(StartTimer(int.parse(items![index].timer??"0"))); // Start timer if there is remaining time

              }
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(
                vertical: AppPadding.pVScreen08(context),
              ),
              child: Container(
                width: AppConstants.wScreen(context),
                height: AppConstants. hScreen(context)*0.126,
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey,
                  borderRadius: BorderRadius.circular(AppRadius.r10,
                  ),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: AppPadding.pHScreen4(context),
                    vertical: AppPadding.pVScreen2(context),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        child: SizedBox(
                          height: AppConstants. hScreen(context)*0.08,
                          width: AppConstants.wScreen(context)*0.16,
                          child: Image.asset(
                            AssetsManager.quizIcon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: AppPadding.pHScreen2(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${items?[index].name}",
                            style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s12),
                          ),
                          SizedBox(height: AppPadding.pVScreen06(context)),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, size: AppSize.s14,color: ColorManager.darkGrey,),
                              SizedBox(width: AppPadding.pHScreen1(context),),
                              Text(
                                "${items?[index].timer} Second",
                                style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                              ),
                            ],
                          ),
                          SizedBox(height: AppPadding.pVScreen06(context)),
                          Row(
                            children: [
                              Icon(Icons.description_outlined, size:AppSize.s14,color: ColorManager.darkGrey,),
                              SizedBox(width: AppPadding.pHScreen1(context),),
                              Text(
                                "${items?[index].numberOfQuestions} Questions",
                                style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (items![index].completed==1)?GestureDetector(
                            onTap: (){
                              context.read<GetModelAnswersBloc>().add(GetModelAnswersRequestEvent(
                                  studentId: context.read<CurrentUserBloc>().userData!.id, quizId:  items![index].id));
                              Navigator.push(context, PageTransition(
                                child: ModelAnswerScreen( quizId:  items![index].id),
                                type: PageTransitionType.fade,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                duration: const Duration(milliseconds: AppConstants.pageTransition200),
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.pHScreen2(context),
                                vertical: AppPadding.pVScreen04(context),
                              ),
                              decoration: BoxDecoration(
                                  color: ColorManager.grey,
                                  borderRadius: BorderRadius.circular(AppRadius.r4)
                              ),
                              child: Text(
                                "Answers",
                                style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s9),
                              ),
                            ),
                          ):SizedBox(),
                          (items![index].completed==1)?SizedBox(height: AppConstants.hScreen(context)*0.03,):SizedBox(height: AppConstants.hScreen(context)*0.06,),
                          Text(
                            (items![index].completed==1)?"Completed":"Not Completed",
                            style: getBoldStyle(color: ColorManager.textGrey,fontSize: FontSize.s9),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
          :CustomEmptyComponent(emptyItemType: "content",),
    );
  }
}