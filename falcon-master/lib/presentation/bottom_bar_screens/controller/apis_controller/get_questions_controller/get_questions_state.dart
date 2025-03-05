part of 'get_questions_bloc.dart';

class GetQuestionsState extends Equatable {
  final QuizEntity? getQuestionsResponse;
  final RequestState requestState;
  final String responseMessage;

  GetQuestionsState({
    this.getQuestionsResponse,
    this.requestState = RequestState.loading,
    this.responseMessage = '',
  });

  @override
  List<Object?> get props => [
        getQuestionsResponse,
        requestState,
        responseMessage,
      ];
}
