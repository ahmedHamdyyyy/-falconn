part of 'rate_and_comment_bloc.dart';



class RateAndCommentState extends Equatable {
  final RateEntity? ratingResponse;
  final RequestState requestState;
  final String responseMessage;

  RateAndCommentState({
    this.ratingResponse ,
    this.requestState = RequestState.loading,
    this.responseMessage = '',
  });

  @override
  List<Object?> get props => [
    ratingResponse,
    requestState,
    responseMessage,
  ];
}

class RateAndCommentLoadingState extends RateAndCommentState {}

