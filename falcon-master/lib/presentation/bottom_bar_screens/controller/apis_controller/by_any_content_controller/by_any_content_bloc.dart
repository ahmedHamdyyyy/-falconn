
import 'dart:async';

import 'package:falcon/core/core_exports.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

part 'by_any_content_event.dart';
part 'by_any_content_state.dart';

class ByAnyContentBloc extends Bloc<ByAnyContentEvent, ByAnyContentState> {
  final ByAnyContentUsecase byAnyContentUsecase;
  ByAnyContentBloc({required this.byAnyContentUsecase}) : super(ByAnyContentInitial()) {
    on<ByAnyContentEventRequestEvent>(_GyAnyContentEventRequestEvent);
  }

  FutureOr<void> _GyAnyContentEventRequestEvent(ByAnyContentEventRequestEvent event, Emitter<ByAnyContentState> emit) async {

    final result = await byAnyContentUsecase(ByAnyContentParameters(
      type: event.type,
      id: event.id,
      studentid: event.studentId,
      code: event.code,
    ));


    result.fold(
            (l)=>emit(ByAnyContentRequestState(
          requestState: RequestState.error,
          responseMessage: l.message,
        )),

        (r)=>emit(ByAnyContentRequestState(
          contentResponse: r,
          requestState: RequestState.done,
        ))
    );


}
}