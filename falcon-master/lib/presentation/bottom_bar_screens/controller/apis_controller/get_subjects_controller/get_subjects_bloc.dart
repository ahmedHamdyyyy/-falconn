import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_subjects_event.dart';
part 'get_subjects_state.dart';

class GetSubjectsBloc extends Bloc<GetSubjectsEvent, GetSubjectsState> {
  final GetUserSubjectsUsecase getUserSubjectsUsecase ;
  GetSubjectsBloc({required this.getUserSubjectsUsecase}) : super(GetSubjectsState()) {
    on<GetSubjectsRequestEvent>(_GetSubjectsRequest);
  }

  FutureOr<void> _GetSubjectsRequest(GetSubjectsRequestEvent event, Emitter<GetSubjectsState> emit) async{
    final result = await getUserSubjectsUsecase(GetUserSubjectsParameters(moduleId: event.moduleId));

    result.fold(
        (l)=>emit(GetSubjectsState(
          requestState: RequestState.error,
          getSubjectsMessage: l.message,
        )),

        (r)=>emit(GetSubjectsState(
          subjectsResponse: r,
          requestState: RequestState.done,
        ))
    );
  }
}
