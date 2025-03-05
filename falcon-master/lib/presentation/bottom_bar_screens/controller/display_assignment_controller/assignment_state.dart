part of 'assignment_bloc.dart';



class AssignmentState extends Equatable {
  final List<QuestionAssignment> questions;
  final List<int?> answers;

  AssignmentState({
    required this.questions,
    List<int?>? answers,
  }) : answers = answers ?? List.filled(questions.length, null);

  @override
  List<Object?> get props => [questions, answers];

  AssignmentState copyWith({
    List<QuestionAssignment>? questions,
    List<int?>? answers,
  }) {
    return AssignmentState(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
    );
  }
}