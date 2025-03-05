
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_chapters_event.dart';
part 'get_chapters_state.dart';

class GetChaptersBloc extends Bloc<GetChaptersEvent, GetChaptersState> {
  final GetUserChaptersUsecase getUserChaptersUsecase ;

  GetChaptersBloc({required this.getUserChaptersUsecase}) : super(GetChaptersState()) {
    on<GetChaptersRequestEvent>(GetChaptersRequest);
  }

  FutureOr<void> GetChaptersRequest(GetChaptersRequestEvent event, Emitter<GetChaptersState> emit) async {
    final result = await getUserChaptersUsecase(GetUserChaptersParameters(subjectId: event.subjectId,userId: event.userId));

    result.fold(
        (l)=>emit(GetChaptersState(
           requestState: RequestState.error,
           getChaptersMessage: l.message,
        )),
        (r)=>emit(GetChaptersState(
           ChaptersResponse: r,
           requestState: RequestState.done,
        ))
    );
  }
}
