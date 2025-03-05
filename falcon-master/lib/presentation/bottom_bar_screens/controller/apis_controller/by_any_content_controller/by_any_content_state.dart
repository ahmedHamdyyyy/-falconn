part of 'by_any_content_bloc.dart';

@immutable
sealed class ByAnyContentState extends Equatable {}

final class ByAnyContentInitial extends ByAnyContentState {

  @override
  List<Object> get props => [];
}

class ByAnyContentRequestState extends ByAnyContentState {

  final ByContentEntity? contentResponse;
  final RequestState requestState;
  final String responseMessage;

  ByAnyContentRequestState({
    this.contentResponse,
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object?> get props => [contentResponse, requestState, responseMessage,];
}
