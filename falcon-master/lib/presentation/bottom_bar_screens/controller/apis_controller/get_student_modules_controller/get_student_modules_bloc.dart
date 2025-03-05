import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_student_modules_event.dart';
part 'get_student_modules_state.dart';

class GetStudentModulesBloc extends Bloc<GetStudentModulesEvent, GetStudentModulesState> {

  final GetStudentModulesUsecase getStudentModulesUsecase ;

  GetStudentModulesBloc({required this.getStudentModulesUsecase}) : super(GetStudentModulesState()) {
    on<GetStudentModulesRequestEvent>(_GetStudentModulesRequest);
  }

  FutureOr<void> _GetStudentModulesRequest(GetStudentModulesRequestEvent event, Emitter<GetStudentModulesState> emit) async{
    final result =  await getStudentModulesUsecase(GetStudentModulesParameters(
      studentId: event.studentId,
    ));

    result.fold(
      (l)=>emit(GetStudentModulesState(
        getModulesRequestState: RequestState.error,
        getModulesMessage: l.message,
      )),

      (r)=>emit(GetStudentModulesState(
        modulesResponse: r,
        getModulesRequestState: RequestState.done,
      )),

    );
  }
}
