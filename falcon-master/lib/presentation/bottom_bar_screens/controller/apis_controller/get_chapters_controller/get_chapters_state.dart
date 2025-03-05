part of 'get_chapters_bloc.dart';

class GetChaptersState extends Equatable {
  final List<ChapterEntity> ChaptersResponse;
  final RequestState requestState;
  final String getChaptersMessage;

  GetChaptersState({
    this.ChaptersResponse = const [],
    this.requestState = RequestState.loading,
    this.getChaptersMessage = "",
  });

  @override
  List<Object> get props => [
        ChaptersResponse,
        requestState,
        getChaptersMessage,
      ];
}
