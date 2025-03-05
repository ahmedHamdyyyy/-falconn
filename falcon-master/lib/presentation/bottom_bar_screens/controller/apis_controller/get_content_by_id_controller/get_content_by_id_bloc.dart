import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_content_by_id_event.dart';
part 'get_content_by_id_state.dart';

class GetContentByIdBloc extends Bloc<GetContentByIdEvent, GetContentByIdState> {
  final ShowContentByIdUsecase showContentByIdUsecase ;

  GetContentByIdBloc({required this.showContentByIdUsecase}) : super(GetContentByIdState()) {
    on<GetContentByIdRequestEvent>(_getContentByIdRequestEvent);
  }

  FutureOr<void> _getContentByIdRequestEvent(GetContentByIdRequestEvent event, Emitter<GetContentByIdState> emit) async{
    final result = await showContentByIdUsecase(ShowContentByIDParameters(contentId:event.contentId,type: DateTime.thursday));

    result.fold(
        (l)=>emit(GetContentByIdState(
          requestState: RequestState.error,
          getContentMessage: l.message,
        )),

        (r)=>emit(GetContentByIdState(
          contentResponse: r,
          requestState: RequestState.done,
        ))
    );
  }
}
