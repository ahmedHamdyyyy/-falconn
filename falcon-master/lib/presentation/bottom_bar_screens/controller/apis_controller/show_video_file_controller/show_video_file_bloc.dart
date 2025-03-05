
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'show_video_file_event.dart';
part 'show_video_file_state.dart';

class ShowVideoFileBloc extends Bloc<ShowVideoFileEvent, ShowVideoFileState> {

  final ShowVideoFileUsecase showVideoFileUsecase;
  ShowVideoFileBloc({required this.showVideoFileUsecase}) : super(ShowVideoFileState()) {
    on<ShowVideoFileRequestEvent>(showVideoFileRequest);
  }

  FutureOr<void> showVideoFileRequest(ShowVideoFileRequestEvent event, Emitter<ShowVideoFileState> emit) async{
    final result =  await showVideoFileUsecase(ShowVideoFileParameters(
      contentId: event.contentId,
    ));

    result.fold(
      (l)=>emit(ShowVideoFileState(
        requestState: RequestState.error,
        responseMessage: l.message,
      )),

      (r)=>emit(ShowVideoFileState(
        videoFileResponse: r,
        requestState: RequestState.done,
      )),

    );
  }
}
