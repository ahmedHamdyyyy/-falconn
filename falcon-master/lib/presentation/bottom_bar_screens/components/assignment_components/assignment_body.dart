import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// context
//     .read<SelectAssignmentAnswerBloc>()
//     .add(AnswerQuestionEvent(questionIndex, value));

class AssignmentBody extends StatelessWidget {
  AssignmentBody({required this.assignmentId,required this.chapterTitle,required this.chapterId,required this.assignmentName,required this.endDate,required this.chapterImage});
  String assignmentId;
   AssignmentEntity? assignment;
  final String? assignmentName;
  final String? endDate;
  final String? chapterImage;
  final String chapterTitle;
  final int chapterId;
  @override
  Widget build(BuildContext context) {
    final int numberOfQuestions = assignment?.questions.length ?? 0;
    return BlocProvider(
  create: (context) => SelectAssignmentAnswerBloc(questionCount:numberOfQuestions),
  child: BlocProvider(
      create: (BuildContext context)=> GetAssignmentBloc(showAssignmentsUsecase: sl<ShowAssignmentsUsecase>())
        ..add(GetAssignmentRequestEvent(assignmentId: int.parse("$assignmentId"))
        ),
      child: BlocBuilder<GetAssignmentBloc,GetAssignmentState>(
          builder: (context , assignmentsResponseState) {
            if(assignmentsResponseState.requestState == RequestState.loading){
              return Skeletonizer(
                child: _AssignmentBodyDetails(chapterTitle: chapterTitle,chapterId: chapterId,assignmentId: assignmentId,chapterImage: chapterImage,endDate: endDate,assignmentName: assignmentName,assignment:AssignmentEntity(subjectName: "subjectName", homeworkName: "homeworkName", questions: [QuestionEntity(questionId: "", question:"---------------------------------", options: OptionModel(option1: "-----------", option2: "-----------", option3: "-----------", option4: "-----------"))]),),
              );
            }
            else if (assignmentsResponseState.requestState == RequestState.done){
              return _AssignmentBodyDetails(chapterTitle: chapterTitle,chapterId: chapterId,assignmentId: assignmentId,chapterImage: chapterImage,assignment:assignmentsResponseState.getAssignmentResponse,assignmentName: assignmentName,endDate: endDate,);
            }
            else {
              return GestureDetector(
                onTap: (){
                  context.read<GetAssignmentBloc>()..add(GetAssignmentRequestEvent(assignmentId: int.parse("$assignmentId")));
                },
                child: Scaffold(
                  body: Container(
                    width: AppConstants.wScreen(context),
                    height: AppConstants.hScreen(context),
                    margin: EdgeInsets.symmetric(
                      horizontal: AppPadding.pHScreen4(context),
                      vertical: AppPadding.pVScreen6(context),
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
                          assignmentsResponseState.responseMessage,
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
                ),
              );
            }
          }
      ),
    ),
);
  }

}

class _AssignmentBodyDetails extends StatelessWidget {
  const _AssignmentBodyDetails({
    super.key,
    required this.assignment,
    required this.assignmentName,
    required this.endDate,
    required this.chapterImage,
    required this.chapterTitle,
    required this.chapterId,
    required this.assignmentId,
  });

  final AssignmentEntity? assignment;
  final String? assignmentName;
  final String? endDate;
  final String? chapterImage;
  final String chapterTitle;
  final int chapterId;
  final String assignmentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectAssignmentAnswerBloc(questionCount: assignment!.questions.length),
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          title: "$assignmentName",
          elevation: 0,
          hasArrowBack: true,
          backgroundColor: ColorManager.primary.withOpacity(0.08),
          appBarHeight: AppConstants.hScreen(context) * 0.07,
        ),
        body: Column(
          children: [
            _buildHeader(context,assignmentId),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pHScreen4(context),
                  vertical: AppPadding.pVScreen2(context),
                ),
                child: ListView.builder(
                  itemCount: assignment!.questions.length,
                  itemBuilder: (context, questionIndex) {
                    final question = assignment!.questions[questionIndex];
                    return _buildQuestion(context, question, questionIndex,question.questionId);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context ,String assignmentId) {
    return Container(
      width: AppConstants.wScreen(context),
      height: AppConstants.hScreen(context) * 0.16,
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pHScreen4(context),
          vertical: AppPadding.pVScreen2(context),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              child: CachedNetworkImage(
                imageUrl: chapterImage!,
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
                  height: AppConstants.hScreen(context) * 0.1,
                  width: AppConstants.wScreen(context) * 0.2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: AppPadding.pHScreen4(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAssignmentInfo(context),
                SizedBox(height: AppPadding.pVScreen1(context)),
                BlocBuilder<SelectAssignmentAnswerBloc, SelectAssignmentAnswerState>(
                  builder: (context, state) {
                    if (state is SelectAssignmentAnswerUpdated &&
                        state.answers.every((answer) => answer != null)) {
                      return _buildSubmitButton(context,assignmentId);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, QuestionEntity question, int questionIndex,String questionId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionText(context, question, questionIndex),
        _buildOptions(context, question, questionIndex , questionId),
      ],
    );
  }

  Widget _buildQuestionText(BuildContext context, QuestionEntity question, int questionIndex) {
    return Container(
      width: AppConstants.wScreen(context),
      height: AppConstants.hScreen(context) * 0.16,
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pHScreen4(context),
        vertical: AppPadding.pVScreen2(context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r10),
        color: ColorManager.lightGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Q (${questionIndex + 1}/${assignment!.questions.length})",
                textAlign: TextAlign.center,
                style: getBoldStyle(color: ColorManager.textGrey.withOpacity(0.6), fontSize: FontSize.s10),
              ),
              Text(
                "",
                textAlign: TextAlign.center,
                style: getBoldStyle(color: ColorManager.textGrey.withOpacity(0.6), fontSize: FontSize.s10),
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  question.question,
                  textAlign: TextAlign.center,
                  style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );

  }

  Widget _buildOptions(BuildContext context, QuestionEntity question, int questionIndex,String questionId) {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildOption(context, questionIndex, 1, question.options.option1,questionId),
        _buildOption(context, questionIndex, 2, question.options.option2,questionId),
        _buildOption(context, questionIndex, 3, question.options.option3,questionId),
        _buildOption(context, questionIndex, 4, question.options.option4,questionId),
      ],
    );
  }

  Widget _buildOption(BuildContext context, int questionIndex, int value, String option,String questionId ) {
    return BlocBuilder<SelectAssignmentAnswerBloc, SelectAssignmentAnswerState>(
      builder: (context, state) {
        final selectedAnswer = (state is SelectAssignmentAnswerUpdated)
            ? state.answers[questionIndex]
            : null;
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppPadding.pHScreen2(context),
            vertical: AppPadding.pVScreen06(context),
          ),
          decoration: BoxDecoration(
            boxShadow: [

            ],
            borderRadius: BorderRadius.circular(AppRadius.r10),
            color: ColorManager.primaryWithOpacity06,
          ),
          child: Theme(
            data:  Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.grey,
            ),
            child: RadioListTile<int>(
              title: Text(option, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),),
              value: value,
              groupValue: selectedAnswer,
              activeColor: ColorManager.primary,
              //fillColor: WidgetStateProperty.all(ColorManager.primary),
              onChanged: (newValue) {
                context.read<SelectAssignmentAnswerBloc>().add(
                  AnswerSelected(questionId:questionId,questionIndex: questionIndex, selectedAnswer: newValue!),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context ,String assignmentId) {
    return BlocProvider(
      create: (context)=> SendAssignmentResultsBloc(Dio()),
      child: BlocBuilder<SendAssignmentResultsBloc, SendAssignmentResultsState>(
          builder: (context, SendQState) {
            if (SendQState is SendAssignmentResultsLoading) {
            } else if (SendQState is SendAssignmentResultsSuccess) {

              Future.delayed(Duration(seconds: 1),(){
                showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"Answers sent successfully ",),);

              });
              Future.delayed(Duration(seconds: 2),(){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, PageTransition(
                  child: BlocProvider(
                    create: (context) => ContentTabBloc(),
                    child: ChaptersContentViews(
                      title: chapterTitle,
                      chapterId: chapterId,
                      chapterImage: chapterImage??"",
                    ),
                  ),
                  type: PageTransitionType.fade,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  duration: const Duration(milliseconds: AppConstants.pageTransition200),
                ));
              });

              // Future.delayed(Duration(seconds: 1),(){
              //   showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"Answers sent successfully ",),);
              //
              // });
              // Future.delayed(Duration(seconds: 2),(){
              //   Navigator.pop(context);
              //
              // });


            }
            else if (SendQState is SendAssignmentResultsError) {
            }
          return GestureDetector(
              onTap: (){
                context.read<SendAssignmentResultsBloc>().add(
                  SendAssignmentResults(
                      studentId: context.read<CurrentUserBloc>().userData!.id,
                      assignmentId: assignmentId,
                      answers: context.read<SelectAssignmentAnswerBloc>().questionsAnswer,
                  ),
                );
              },
            child: Container(
              width: AppConstants.wScreen(context)*0.3,
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pHScreen2(context),
                vertical: AppPadding.pVScreen08(context),
              ),
              margin: EdgeInsets.only(
                left: AppConstants.wScreen(context)*0.0,
              ),
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppRadius.r4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Submit",
                    style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s12),
                  ),
                  Icon(Icons.send_rounded, color: ColorManager.white, size: AppSize.s20),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildAssignmentInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$assignmentName",
          style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
        ),
        Row(
          children: [
            Icon(Icons.timer_outlined, size: AppSize.s14, color: ColorManager.darkGrey),
            SizedBox(width: AppPadding.pHScreen1(context)),
            Text(
              "Valid till $endDate",
              style: getBoldStyle(color: ColorManager.textGrey, fontSize: FontSize.s9),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.description_outlined, size: AppSize.s14, color: ColorManager.darkGrey),
            SizedBox(width: AppPadding.pHScreen1(context)),
            Text(
              "${assignment!.questions.length} Questions",
              style: getBoldStyle(color: ColorManager.textGrey, fontSize: FontSize.s9),
            ),
          ],
        ),
      ],
    );
  }
}


// class _AssignmentBodyDetails extends StatelessWidget {
//   const _AssignmentBodyDetails({
//     super.key,
//     required this.assignment,
//     required this.assignmentName,
//     required this.endDate,
//     required this.chapterImage,
//   });
//
//
//   final AssignmentEntity? assignment;
//   final String? assignmentName;
//   final String? endDate;
//   final String? chapterImage;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         context: context,
//         title: "${assignmentName}",
//         elevation: 0,
//         hasArrowBack: true,
//         backgroundColor: ColorManager.primary.withOpacity(0.08),
//         appBarHeight: AppConstants.hScreen(context) * 0.07,
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: AppConstants.wScreen(context),
//             height: AppConstants.hScreen(context) * 0.16,
//             decoration: BoxDecoration(
//               color: ColorManager.primary.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(
//                 AppRadius.r10,
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppPadding.pHScreen4(context),
//                 vertical: AppPadding.pVScreen2(context),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(AppRadius.r8),
//                     child: SizedBox(
//                       child:CachedNetworkImage(
//                         imageUrl:chapterImage!,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => Skeletonizer(
//                           child: Container(
//                             color: ColorManager.lightGrey,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                         errorWidget: (context, url, error) => Image.asset(
//                           AssetsManager.defaultImage,
//                           height: AppConstants.hScreen(context) * 0.1,
//                           width: AppConstants.wScreen(context) * 0.2,
//                           fit: BoxFit.fill,
//                         ),
//
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: AppPadding.pHScreen2(context)),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "$assignmentName",
//                         style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),),
//                       SizedBox(height: AppPadding.pVScreen06(context)),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.timer_outlined,
//                             size: AppSize.s14,
//                             color: ColorManager.darkGrey,
//                           ),
//                           SizedBox(
//                             width: AppPadding.pHScreen1(context),
//                           ),
//                           Text(
//                             "Valid till ${endDate}",
//                             style: getBoldStyle(
//                                 color: ColorManager.textGrey,
//                                 fontSize: FontSize.s9),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: AppPadding.pVScreen06(context)),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.description_outlined,
//                             size: AppSize.s14,
//                             color: ColorManager.darkGrey,
//                           ),
//                           SizedBox(
//                             width: AppPadding.pHScreen1(context),
//                           ),
//                           Text(
//                             "${assignment!.questions.length} Questions ",
//                             style: getBoldStyle(
//                                 color: ColorManager.textGrey,
//                                 fontSize: FontSize.s9),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       BlocBuilder<SelectAssignmentAnswerBloc, SelectAssignmentAnswerState>(
//                         builder: (context, state) {
//                           if (state is SelectAssignmentAnswerUpdated &&
//                               state.answers.every((answer) => answer != null)) {
//                             return Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: AppPadding.pHScreen2(context),
//                                 vertical: AppPadding.pVScreen1(context),
//                               ),
//                               decoration: BoxDecoration(
//                                   color: ColorManager.primary,
//                                   borderRadius: BorderRadius.circular(AppRadius.r4)
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Submit",
//                                     style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s12).copyWith(
//                                       // decoration: TextDecoration.underline,
//                                       // decorationColor:ColorManager.primary,
//                                     ),
//
//                                   ),
//                                   SizedBox(
//                                     width: AppPadding.pHScreen4(context),
//                                   ),
//                                   Icon(Icons.send_rounded,color: ColorManager.white,size: AppSize.s20,),
//                                 ],
//                               ),
//                             );
//                           }
//                           return SizedBox.shrink(); // Hide the button if not all questions are answered
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppPadding.pHScreen4(context),
//                 vertical: AppPadding.pVScreen2(context),
//               ),
//               child: ListView.builder(
//                 itemCount: assignment!.questions.length,
//                 itemBuilder: (context, questionIndex) {
//
//                   final question = assignment!.questions[questionIndex];
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: AppConstants.wScreen(context),
//                         height: AppConstants.hScreen(context) * 0.16,
//                         padding: EdgeInsets.symmetric(
//                           horizontal: AppPadding.pHScreen4(context),
//                           vertical: AppPadding.pVScreen2(context),
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(AppRadius.r10),
//                           color: ColorManager.lightGrey,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Q (${questionIndex + 1}/${assignment!.questions.length})",
//                                   textAlign: TextAlign.center,
//                                   style: getBoldStyle(color: ColorManager.textGrey.withOpacity(0.6), fontSize: FontSize.s10),
//                                 ),
//                                 Text(
//                                   "1 Mark",
//                                   textAlign: TextAlign.center,
//                                   style: getBoldStyle(color: ColorManager.textGrey.withOpacity(0.6), fontSize: FontSize.s10),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Flexible(
//                                   child: Text(
//                                     question.question,
//                                     textAlign: TextAlign.center,
//                                     style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                           ],
//                         ),
//                       ),
//                       // Wrap all RadioListTile widgets in a single Container
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             vertical: AppPadding.pVScreen2(context)),
//                         child: Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: AppPadding.pHScreen2(context),
//                               vertical: AppPadding.pVScreen06(context)),
//                           child: ListView(
//                             shrinkWrap: true,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: AppPadding.pHScreen2(context),
//                                   vertical: AppPadding.pVScreen06(context),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//
//                                   ],
//                                   borderRadius: BorderRadius.circular(AppRadius.r10),
//                                   color: ColorManager.primaryWithOpacity06,
//                                 ),
//                                 child: Theme(
//                                   data:  Theme.of(context).copyWith(
//                                     unselectedWidgetColor: Colors.grey,
//                                   ),
//                                   child: RadioListTile<int>(
//                                     title: Text(
//                                       question.options.option1,
//                                       style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
//                                     ),
//                                     value: ,
//                                     groupValue: ,
//                                     activeColor: ColorManager.primary,
//                                     //fillColor: WidgetStateProperty.all(ColorManager.primary),
//                                     onChanged: (value) {
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: AppPadding.pHScreen2(context),
//                                   vertical: AppPadding.pVScreen06(context),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//
//                                   ],
//                                   borderRadius: BorderRadius.circular(AppRadius.r10),
//                                   color: ColorManager.primaryWithOpacity06,
//                                 ),
//                                 child: Theme(
//                                   data:  Theme.of(context).copyWith(
//                                     unselectedWidgetColor: Colors.grey,
//                                   ),
//                                   child: RadioListTile<int>(
//                                     title: Text(
//                                       question.options.option2,
//                                       style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
//                                     ),
//                                     value: ,
//                                     groupValue: ,
//                                     activeColor: ColorManager.primary,
//                                     //fillColor: WidgetStateProperty.all(ColorManager.primary),
//                                     onChanged: (value) {
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: AppPadding.pHScreen2(context),
//                                   vertical: AppPadding.pVScreen06(context),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//
//                                   ],
//                                   borderRadius: BorderRadius.circular(AppRadius.r10),
//                                   color: ColorManager.primaryWithOpacity06,
//                                 ),
//                                 child: Theme(
//                                   data:  Theme.of(context).copyWith(
//                                     unselectedWidgetColor: Colors.grey,
//                                   ),
//                                   child: RadioListTile<int>(
//                                     title: Text(
//                                       question.options.option3,
//                                       style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
//                                     ),
//                                       value: ,
//                                       groupValue: ,
//                                       activeColor: ColorManager.primary,
//                                       //fillColor: WidgetStateProperty.all(ColorManager.primary),
//                                       onChanged: (value) {
//                                       },
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: AppPadding.pHScreen2(context),
//                                   vertical: AppPadding.pVScreen06(context),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//
//                                   ],
//                                   borderRadius: BorderRadius.circular(AppRadius.r10),
//                                   color: ColorManager.primaryWithOpacity06,
//                                 ),
//                                 child: Theme(
//                                   data:  Theme.of(context).copyWith(
//                                     unselectedWidgetColor: Colors.grey,
//                                   ),
//                                   child: RadioListTile<int>(
//                                     title: Text(
//                                       question.options.option4,
//                                       style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
//                                     ),
//                                     value: ,
//                                     groupValue: ,
//                                     activeColor: ColorManager.primary,
//                                     //fillColor: WidgetStateProperty.all(ColorManager.primary),
//                                     onChanged: (value) {
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
