part of 'request_content_bloc.dart';

@immutable
sealed class RequestContentState extends Equatable{}

final class RequestContentInitial extends RequestContentState {

  @override
  List<Object> get props => [];
}

class RequestContentRequestState extends RequestContentState {

  final RequestContentEntity? requestContentResponse;
  final RequestState requestState;
  final String responseMessage;

  RequestContentRequestState({
    this.requestContentResponse,
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object?> get props => [requestContentResponse, requestState, responseMessage,];
}
