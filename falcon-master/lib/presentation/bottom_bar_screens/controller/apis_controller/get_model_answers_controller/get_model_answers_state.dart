part of 'get_model_answers_bloc.dart';

class GetModelAnswersState extends Equatable {

  final List<AnswerCorrectEntity> getAnswerQuestionResponse;
  final RequestState requestState;
  final String responseMessage;

  GetModelAnswersState({
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