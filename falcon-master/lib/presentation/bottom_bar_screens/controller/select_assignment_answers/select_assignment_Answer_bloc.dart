import "package:falcon/core/core_exports.dart";
// Events
// SelectAssignmentAnswerEvent.dart
abstract class SelectAssignmentAnswerEvent extends Equatable {
  const SelectAssignmentAnswerEvent();

  @override
  List<Object?> get props => [];
}

class AnswerSelected extends SelectAssignmentAnswerEvent {
  final String questionId;
  final int questionIndex;
  final int selectedAnswer;

  const AnswerSelected({required this.questionId,required this.questionIndex, required this.selectedAnswer});

  @override
  List<Object?> get props => [questionIndex, selectedAnswer];
}

// SelectAssignmentAnswerState.dart
abstract class SelectAssignmentAnswerState extends Equatable {
  const SelectAssignmentAnswerState();

  @override
  List<Object?> get props => [];
}

class SelectAssignmentAnswerInitial extends SelectAssignmentAnswerState {}

class SelectAssignmentAnswerUpdated extends SelectAssignmentAnswerState {
  final List<int?> answers;

  const SelectAssignmentAnswerUpdated(this.answers);

  @override
  List<Object?> get props => [answers];
}

// SelectAssignmentAnswerBloc.dart
class SelectAssignmentAnswerBloc extends Bloc<SelectAssignmentAnswerEvent, SelectAssignmentAnswerState> {
  final int questionCount;
  List<Map<String,dynamic>> questionsAnswer = [];

  SelectAssignmentAnswerBloc({required this.questionCount})
      : super(SelectAssignmentAnswerInitial()) {
    on<AnswerSelected>((event, emit) {
      final currentState = state;
      if (currentState is SelectAssignmentAnswerUpdated) {
        final updatedAnswers = List<int?>.from(currentState.answers);
        updatedAnswers[event.questionIndex] = event.selectedAnswer;

        emit(SelectAssignmentAnswerUpdated(updatedAnswers));
      } else {
        final initialAnswers = List<int?>.filled(questionCount, null);
        initialAnswers[event.questionIndex] = event.selectedAnswer;

        emit(SelectAssignmentAnswerUpdated(initialAnswers));
      }

      bool canAdd = false;
      if(questionsAnswer.isNotEmpty){
        for (int i = 0; i < questionsAnswer.length; i++) {
          if (questionsAnswer[i]["questionid"] == event.questionId) {
            questionsAnswer[i]["choice"] = event.selectedAnswer;
            canAdd = false;
            break;
          } else {
            canAdd = true;
          }
        }
        if (canAdd) {
          questionsAnswer.add({
            "questionid": event.questionId,
            "choice": event.selectedAnswer,
          });
        }
      }else{
        questionsAnswer.add({
          "questionid": event.questionId,
          "choice": event.selectedAnswer,
        });
      }




    });
  }
}
