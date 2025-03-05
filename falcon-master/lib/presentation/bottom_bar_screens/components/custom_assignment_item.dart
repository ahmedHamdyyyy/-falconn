import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomAssignmentItem extends StatelessWidget {
  const CustomAssignmentItem({
    super.key,
    required this.items,
    required this.chapterImage,
    required this.chapterTitle,
    required this.chapterId,
  });
  final List<ContentEntity>? items;
  final String chapterImage;
  final String chapterTitle;
  final String chapterId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: AppPadding.pHScreen4(context),
        vertical: AppPadding.pVScreen2(context),
      ),
      child: ListView.builder(
        itemCount: items?.length,
        padding: EdgeInsets.all(0),
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              if(items![index].completed==1){
                showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message:"You have already completed this quiz",),);
              }
              if(items![index].completed!=1){
                Navigator.push(context, PageTransition(
                  child: BlocProvider(
                    create: (context) => AssignmentBloc(),
                    child: AssignmentBody(chapterId: int.parse(chapterId),chapterTitle: chapterTitle,chapterImage:chapterImage,assignmentId:  items![index].id,assignmentName: items![index].name,endDate:items![index].enddate ),
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
                                  studentId: context.read<CurrentUserBloc>().userData!.id, quizId:  items![index].id));
                              Navigator.push(context, PageTransition(
                                child: AssignmentAnswer(quizId: items![index].id),
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
      ),
    );
  }
}