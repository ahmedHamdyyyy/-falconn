part of 'get_assignment_answer_bloc.dart';

@immutable
sealed class GetAssignmentAnswerEvent {}

class GetAssignmentAnswerRequestEvent extends GetAssignmentAnswerEvent {

  final String studentId;
  final String quizId;

  GetAssignmentAnswerRequestEvent({
    required this.studentId,
    required this.quizId,
  });

  @override
  List<Object> get props => [studentId, quizId];
}
