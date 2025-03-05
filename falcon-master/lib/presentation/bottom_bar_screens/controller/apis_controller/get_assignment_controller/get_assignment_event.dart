part of 'get_assignment_bloc.dart';

@immutable
sealed class GetAssignmentEvent {}

class GetAssignmentRequestEvent extends GetAssignmentEvent {

  final int assignmentId;
  GetAssignmentRequestEvent({required this.assignmentId});

  @override
  List<Object> get props => [assignmentId];
}
