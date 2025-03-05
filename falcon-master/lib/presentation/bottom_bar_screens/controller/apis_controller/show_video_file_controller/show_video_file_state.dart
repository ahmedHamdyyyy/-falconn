part of 'show_video_file_bloc.dart';

class ShowVideoFileState extends Equatable {

  final VideoFileEntity? videoFileResponse;
  final RequestState requestState;
  final String responseMessage;

  ShowVideoFileState({
    this.videoFileResponse,
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object?> get props => [
    videoFileResponse,
        requestState,
        responseMessage,
      ];
}
