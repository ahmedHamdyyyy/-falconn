part of 'get_assignment_answer_bloc.dart';

class GetAssignmentAnswerState extends Equatable {

  final List<AssignmentAnswerEntity> getAnswerQuestionResponse;
  final RequestState requestState;
  final String responseMessage;

  GetAssignmentAnswerState({
    this.getAnswerQuestionResponse = const [],
    this.requestState = RequestState.loading,
    this.responseMessage = '',
  });

  @override
  List<Object> get props => [
    getAnswerQuestionResponse,
    requestState,
    responseMessage,
  ];
}