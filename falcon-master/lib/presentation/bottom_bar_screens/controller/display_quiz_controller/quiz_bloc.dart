import 'package:falcon/core/core_exports.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final List<QuestionEntity> questions;
  final  String studentId;
  final  String quizId ;
  List<Map<String,dynamic>> questionsAnswer = [];

  QuizBloc({required this.questions,required this.studentId,required this.quizId}) : super(QuizInitial()) {
    on<LoadQuiz>((event, emit) {
      // Initialize with the first question and no selected answers
      emit(QuizLoaded(0, List<String?>.filled(questions.length, null), false));
    });

    on<NextQuestion>((event, emit) {
      if (state is QuizLoaded) {
        final currentState = state as QuizLoaded;
        if (currentState.currentIndex < questions.length - 1) {
          emit(QuizLoaded(currentState.currentIndex + 1, currentState.selectedAnswers, currentState.allQuestionsAnswered));
        }
      }
    });

    on<PreviousQuestion>((event, emit) {
      if (state is QuizLoaded) {
        final currentState = state as QuizLoaded;
        if (currentState.currentIndex > 0) {
          emit(QuizLoaded(currentState.currentIndex - 1, currentState.selectedAnswers, currentState.allQuestionsAnswered));
        }
      }
    });

    on<ConfirmAnswers>((event, emit) {
      // Print the questionsAnswer when ConfirmAnswers event is added
      Map finalResult ={
        "studentid": studentId,
        "quizid":quizId,
        "answers": questionsAnswer
      };

      //questionsAnswer.remove({"questionid": "null","choice": "null"});



    });

    on<SelectAnswer>((event, emit) {
      if (state is QuizLoaded) {
        final currentState = state as QuizLoaded;
        final updatedAnswers = List<String?>.from(currentState.selectedAnswers);
        updatedAnswers[event.questionIndex] = event.answer;

        bool allQuestionsAnswered = !updatedAnswers.contains(null);

        emit(QuizLoaded(currentState.currentIndex, updatedAnswers, allQuestionsAnswered));

        bool canAdd = false;
        if(questionsAnswer.isNotEmpty){
          for (int i = 0; i < questionsAnswer.length; i++) {
            if (questionsAnswer[i]["questionid"] == event.questionId) {
              questionsAnswer[i]["choice"] = event.answerIndex;
              canAdd = false;
              break;
            } else {
              canAdd = true;
            }
          }
          if (canAdd) {
            questionsAnswer.add({
              "questionid": event.questionId,
              "choice": event.answerIndex,
            });
          }
        }else{
          questionsAnswer.add({
            "questionid": event.questionId,
            "choice": event.answerIndex,
          });
        }


      }
    });
  }
}
