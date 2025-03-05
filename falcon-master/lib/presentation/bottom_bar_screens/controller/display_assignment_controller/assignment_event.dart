part of 'assignment_bloc.dart';

abstract class AssignmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadQuestions extends AssignmentEvent {}

class AnswerQuestion extends AssignmentEvent {
  final int questionIndex;
  final int selectedAnswerIndex;

  AnswerQuestion(this.questionIndex, this.selectedAnswerIndex);

  @override
  List<Object> get props => [questionIndex, selectedAnswerIndex];
}