import 'dart:async';

import 'package:falcon/core/core_exports.dart';


part 'get_assignment_event.dart';
part 'get_assignment_state.dart';

class GetAssignmentBloc extends Bloc<GetAssignmentEvent, GetAssignmentState> {
  final ShowAssignmentsUsecase showAssignmentsUsecase;
  GetAssignmentBloc({required this.showAssignmentsUsecase}) : super(GetAssignmentState()) {
    on<GetAssignmentRequestEvent>(_GetAssignmentRequestEvent);
  }

  FutureOr<void> _GetAssignmentRequestEvent(GetAssignmentRequestEvent event, Emitter<GetAssignmentState> emit) async{
    final result =  await showAssignmentsUsecase(ShowAssignmentsParameters(assignmentId: event.assignmentId,));

    result.fold(
          (l)=>emit(GetAssignmentState(
        requestState: RequestState.error,
        responseMessage: l.message,
      )),

          (r)=>emit(GetAssignmentState(
        getAssignmentResponse: r,
        requestState: RequestState.done,
      )),

    );
  }
}
