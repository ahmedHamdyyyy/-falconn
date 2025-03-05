part of 'send_quiz_results_bloc.dart';

abstract class SendQuizResultsState extends Equatable {
  const SendQuizResultsState();

  @override
  List<Object> get props => [];
}

class SendQuizResultsInitial extends SendQuizResultsState {}

class SendQuizResultsLoading extends SendQuizResultsState {}

class SendQuizResultsSuccess extends SendQuizResultsState {
  final String successMessage;

  const SendQuizResultsSuccess(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

class SendQuizResultsError extends SendQuizResultsState {
  final String errorMessage;

  const SendQuizResultsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
