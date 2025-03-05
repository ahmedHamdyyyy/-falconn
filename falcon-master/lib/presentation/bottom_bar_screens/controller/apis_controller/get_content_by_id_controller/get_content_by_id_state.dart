part of 'get_content_by_id_bloc.dart';

class GetContentByIdState extends Equatable {
  final ContentEntity? contentResponse;
  final RequestState requestState;
  final String getContentMessage;

  GetContentByIdState({
    this.contentResponse,
    this.requestState = RequestState.loading,
    this.getContentMessage = "",
  });

  @override
  List<Object?> get props => [
        contentResponse,
        requestState,
        getContentMessage,
      ];
}
