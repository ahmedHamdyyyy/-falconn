
import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class QuizBody extends StatelessWidget {
  QuizBody({super.key,required this.chapterId,required this.chapterTitle,required this.quizId, required this.quizTimer,required this.chapterImage,required this.name});

   int quizId;
   String? quizTimer;
   String? chapterImage;
   String chapterTitle;
   int chapterId;
   String? name;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> GetQuestionsBloc(showQuestionsUsecase: sl<ShowQuestionsUsecase>())
        ..add(GetQuestionsRequestEvent(quizId: quizId)
        ),
      child: BlocBuilder<GetQuestionsBloc,GetQuestionsState>(
          builder: (context , questionsResponseState) {
          if(questionsResponseState.requestState == RequestState.loading){
            return Skeletonizer(
              child: _QuizBodyDetails(chapterTitle: chapterTitle,chapterId: chapterId,quizId: quizId.toString(),quizTimer: quizTimer,questions:[QuestionEntity(questionId: "", question:"---------------------------------",options: OptionModel(option1: "-----------", option2: "-----------", option3: "-----------", option4: "-----------"))],chapterImage: "",name: name,),
            );
          }else if (questionsResponseState.requestState == RequestState.done){
            return _QuizBodyDetails(chapterTitle: chapterTitle,chapterId: chapterId,quizId: quizId.toString(),chapterImage: chapterImage,questions:questionsResponseState.getQuestionsResponse!.questions,quizTimer: quizTimer,name: name,);
          }else {
            return GestureDetector(
              onTap: (){
                context.read<GetQuestionsBloc>()..add(GetQuestionsRequestEvent(quizId:quizId));
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
                        questionsResponseState.responseMessage,
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
    );
  }
}

class _QuizBodyDetails extends StatelessWidget {
  _QuizBodyDetails({
    super.key,
    required this.quizId,
    required this.questions,
    required this.quizTimer,
    required this.chapterImage,
    required this.chapterTitle,
    required this.chapterId,
    required this.name,
  });

  final String quizId;
  final List<QuestionEntity> questions;
  final PageController _pageController = PageController();
  final String? quizTimer ;
  final String? chapterImage ;
  final String chapterTitle ;
  final int chapterId ;
  final String? name ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(questions: questions,studentId: context.read<CurrentUserBloc>().userData!.id,quizId: quizId)..add(LoadQuiz(),),
      child: Scaffold(
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoaded) {
              return Column(
                children: [
                  // Pass the pageController safely to QuizInfo
                  QuizInfo(
                    name: name,
                    quizTimer: quizTimer,
                    quizState: state,
                    questions: questions,
                    chapterImage:chapterImage ,
                    pageController: _pageController,
                  ),

                  SizedBox(height: AppPadding.pHScreen8(context)),

                  // Pass the pageController safely to QuizPageView
                  QuizPageView(
                    quizId: quizId,
                    quizState: state,
                    questions: questions,
                    pageController: _pageController,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.pHScreen4(context),
                      vertical: AppPadding.pVScreen1_5(context),
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.06),
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: ColorManager.grey.withOpacity(0.6),
                          width: 1.4,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onPressed: () {
                            if (_pageController.hasClients) {
                              final currentPage = _pageController.page?.toInt() ?? 0;
                              if (currentPage > 0) {
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: AppConstants.pageTransition200),
                                  curve: Curves.linearToEaseOut,
                                );
                              }
                            }
                          },
                          heightButton: AppConstants.hScreen(context) * 0.04,
                          widthButton: AppConstants.wScreen(context) * 0.24,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.pHScreen4(context),
                          ),
                          backgroundColor: (_pageController.hasClients && _pageController.page != null && _pageController.page! < 0.5) ?
                          ColorManager.darkGrey.withOpacity(0.3) : ColorManager.primary,
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: ColorManager.white,
                                size: AppSize.s20,
                              ),
                              Text(
                                "Back",
                                style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s12),
                              ),
                            ],
                          ),
                        ),
                        BlocProvider(
                          create: (context)=> SendQuizResultsBloc(Dio()),
                          child: BlocBuilder<SendQuizResultsBloc, SendQuizResultsState>(
                            builder: (context, SendQState) {
                              if (SendQState is SendQuizResultsLoading) {
                              } else if (SendQState is SendQuizResultsSuccess) {

                                Future.delayed(Duration(seconds: 1),(){
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
                                  showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"Answers sent successfully ",),);
                                });

                                 // Future.delayed(Duration(seconds: 1),(){
                                 //   showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message:"Answers sent successfully ",),);
                                 //
                                 // });
                                 // Future.delayed(Duration(seconds: 3),(){
                                 //   Navigator.pop(context);
                                 //
                                 // });


                              }
                              else if (SendQState is SendQuizResultsError) {
                              }
                              return  (state.allQuestionsAnswered)?CustomButton(
                                onPressed: () {
                                  context.read<SendQuizResultsBloc>().add(
                                    SendQuizResults(
                                      studentId: context.read<CurrentUserBloc>().userData!.id,
                                      quizId: quizId,
                                      answers: context.read<QuizBloc>().questionsAnswer
                                    ),
                                  );


                                },
                                heightButton: AppConstants.hScreen(context) * 0.04,
                                widthButton: AppConstants.wScreen(context) * 0.24,
                                borderRadius: BorderRadius.circular(AppRadius.r8),
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.pHScreen4(context),
                                ),
                                backgroundColor: ColorManager.primary,
                                elevation: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Submit",
                                      style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s12),
                                    ),
                                  ],
                                ),
                              ):SizedBox();
                            },
                          ),
                        ),

                        CustomButton(
                          onPressed: () {
                            if (_pageController.hasClients) {
                              final currentPage = _pageController.page?.toInt() ?? 0;
                              if (currentPage < (questions.length - 1)) {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: AppConstants.pageTransition200),
                                  curve: Curves.linearToEaseOut,
                                );
                              }
                            }
                          },
                          heightButton: AppConstants.hScreen(context) * 0.04,
                          widthButton: AppConstants.wScreen(context) * 0.24,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.pHScreen4(context),
                          ),
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Next",
                                style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s12),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorManager.white,
                                size: AppSize.s20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}




