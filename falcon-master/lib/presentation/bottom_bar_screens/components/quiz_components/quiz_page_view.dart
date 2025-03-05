import 'package:falcon/core/core_exports.dart';

class QuizPageView extends StatelessWidget {
   QuizPageView({
    super.key,
    required this.quizId,
    required this.quizState,
    required this.questions,
    required this.pageController,

  });

  final String quizId;
  final QuizLoaded quizState;
  final List<QuestionEntity> questions;
   PageController pageController ;

  @override
  Widget build(BuildContext context) {
   // pageController = PageController(initialPage: quizState.currentIndex);
    return Expanded(
      child: PageView.builder(
        itemCount: questions.length,
        controller: pageController,
        onPageChanged: (index) {

          if (index > quizState.currentIndex) {
            context.read<QuizBloc>().add(NextQuestion());
          } else {
            context.read<QuizBloc>().add(PreviousQuestion());
          }
        },
        itemBuilder: (context, index) {
          final question = questions[index];
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pHScreen4(context),
              ),
              child: Column(
                children: [
                  Container(
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
                              "Q (${index + 1}/${questions.length})",
                              textAlign: TextAlign.center,
                              style: getBoldStyle(color: ColorManager.textGrey.withOpacity(0.6), fontSize: FontSize.s10),
                            ),
                            Text(
                              "1 Mark",
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
                                "${question.question}",
                                textAlign: TextAlign.center,
                                style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppConstants.hScreen(context) * 0.03,
                  ),
                  SizedBox(
                    height: AppConstants.hScreen(context) * 0.382,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        QuizAnswerOption(
                          quizId: quizId,
                          index: 0,
                          quizState: quizState,
                          answer: question.options.option1,
                          questionIndex: index,
                          questionId: question.questionId,
                          answerId: "1",
                        ),
                        QuizAnswerOption(
                          quizId: quizId,
                          index: 0,
                          quizState: quizState,
                          answer: question.options.option2,
                          questionIndex: index,
                          questionId: question.questionId,
                          answerId: "2",
                        ),
                        QuizAnswerOption(
                          quizId: quizId,
                          index: 0,
                          quizState: quizState,
                          answer: question.options.option3,
                          questionIndex: index,
                          questionId: question.questionId,
                          answerId: "3",
                        ),
                        QuizAnswerOption(
                          quizId: quizId,
                          index: 0,
                          quizState: quizState,
                          answer: question.options.option4,
                          questionIndex: index,
                          questionId: question.questionId,
                          answerId: "4",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}