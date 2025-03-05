
import 'package:falcon/core/core_exports.dart';

class QuizAnswerOption extends StatelessWidget {
  const QuizAnswerOption({
    super.key,
    required this.quizId,
    required this.index,
    required this.answer,
    required this.quizState,
    required this.questionIndex, // Add questionIndex parameter
    required this.questionId,
    required this.answerId,
  });

  final String quizId;
  final int index;
  final String answer;
  final QuizLoaded quizState;
  final int questionIndex; // Store question index
  final String questionId;
  final String answerId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<QuizBloc>().add(SelectAnswer(
          quizId: quizId,
            questionIndex:  questionIndex,
            answer: answer,
            questionId: questionId,
            answerIndex: answerId,
        )); // Pass the questionIndex
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pHScreen4(context),
          vertical: AppPadding.pVScreen1_5(context),
        ),
        margin: EdgeInsets.symmetric(
          vertical: AppPadding.pVScreen08(context),
        ),
        decoration: BoxDecoration(
          border: Border.all(color:ColorManager.lightGrey.withOpacity(0.8), ),
          borderRadius: BorderRadius.circular(AppRadius.r10),
          color:ColorManager.primaryWithOpacity06,
          // boxShadow: [
          //   BoxShadow(
          //     color: ColorManager.grey.withOpacity(0.6),
          //     offset: Offset(1.5, 2),
          //     spreadRadius: 1,
          //     blurRadius: 1,
          //   ),
          // ],

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                answer,
                style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s12),
              ),
            ),
            (quizState.selectedAnswers[questionIndex] == answer) // Use questionIndex here to check if this option is selected
                ? Icon(Icons.check, color: ColorManager.primary, size: AppSize.s24)
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
