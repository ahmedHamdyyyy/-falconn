
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_all_doctors_event.dart';
part 'get_all_doctors_state.dart';

class GetAllDoctorsBloc extends Bloc<GetAllDoctorsEvent, GetAllDoctorsState> {

  final ShowAllDoctorsUsecase showAllDoctorsUsecase ;

  GetAllDoctorsBloc({required this.showAllDoctorsUsecase}) : super(GetAllDoctorsState()) {
    on<GetAllDoctorsRequestEvent>(_GetAllDoctorsRequest);
  }

  FutureOr<void> _GetAllDoctorsRequest(GetAllDoctorsRequestEvent event, Emitter<GetAllDoctorsState> emit) async{
    final result = await showAllDoctorsUsecase(NoParameters());

    result.fold(
       (l)=>emit(GetAllDoctorsState(
          requestState: RequestState.error,
          responseMessage: l.message,
        )),

        (r)=>emit(GetAllDoctorsState(
          getDoctorsResponse: r,
          requestState: RequestState.done,
        ))
    );
  }
}
