part of 'send_assignment_results_bloc.dart';

abstract class SendAssignmentResultsEvent extends Equatable {
  const SendAssignmentResultsEvent();

  @override
  List<Object> get props => [];
}

class SendAssignmentResults extends SendAssignmentResultsEvent {
  final String studentId;
  final String assignmentId;
  final List<Map<String, dynamic>> answers;

  const SendAssignmentResults({
    required this.studentId,
    required this.assignmentId,
    required this.answers,
  });

  @override
  List<Object> get props => [studentId, assignmentId, answers];
}
