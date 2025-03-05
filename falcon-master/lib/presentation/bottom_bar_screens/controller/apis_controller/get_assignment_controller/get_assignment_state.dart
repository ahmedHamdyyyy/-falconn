part of 'get_assignment_bloc.dart';


class GetAssignmentState extends Equatable {
  final AssignmentEntity? getAssignmentResponse;
  final RequestState requestState;
  final String responseMessage;

  GetAssignmentState({
    this.getAssignmentResponse,
    this.requestState = RequestState.loading,
    this.responseMessage = '',
  });

  @override
  List<Object?> get props => [
    getAssignmentResponse,
    requestState,
    responseMessage,
  ];
}