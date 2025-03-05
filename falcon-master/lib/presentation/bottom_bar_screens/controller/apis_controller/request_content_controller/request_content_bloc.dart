
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'request_content_event.dart';
part 'request_content_state.dart';

class RequestContentBloc extends Bloc<RequestContentEvent, RequestContentState> {
  final RequestContentUsecase requestContentUsecase;
  RequestContentBloc({required this.requestContentUsecase}) : super(RequestContentInitial()) {
    on<RequestContentEventRequestEvent>(_RequestContentEventRequestEvent);
  }

  FutureOr<void> _RequestContentEventRequestEvent(RequestContentEventRequestEvent event, Emitter<RequestContentState> emit) async {

    final result = await requestContentUsecase(RequestContentParameters(
      type: event.type,
      id: event.id,
      studentid: event.studentId,
    ));


    result.fold(
            (l)=>emit(RequestContentRequestState(
          requestState: RequestState.error,
          responseMessage: l.message,
        )),

            (r)=>emit(RequestContentRequestState(
          requestContentResponse: r,
          requestState: RequestState.done,
        ))
    );



  }
}
