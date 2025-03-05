part of 'send_assignment_results_bloc.dart';

abstract class SendAssignmentResultsState extends Equatable {
  const SendAssignmentResultsState();

  @override
  List<Object> get props => [];
}

class SendAssignmentResultsInitial extends SendAssignmentResultsState {}

class SendAssignmentResultsLoading extends SendAssignmentResultsState {}

class SendAssignmentResultsSuccess extends SendAssignmentResultsState {
  final String successMessage;

  const SendAssignmentResultsSuccess(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

class SendAssignmentResultsError extends SendAssignmentResultsState {
  final String errorMessage;

  const SendAssignmentResultsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
