import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/core_exports.dart';

part 'get_assignment_answer_event.dart';
part 'get_assignment_answer_state.dart';

class GetAssignmentAnswerBloc extends Bloc<GetAssignmentAnswerEvent, GetAssignmentAnswerState> {
  final GetAssignmentAnswerUsecase getAssignmentAnswerUsecase;

  GetAssignmentAnswerBloc({required this.getAssignmentAnswerUsecase}) : super(GetAssignmentAnswerState()) {
    on<GetAssignmentAnswerRequestEvent>(_GetModelAnswersRequest);
  }

  FutureOr<void> _GetModelAnswersRequest(GetAssignmentAnswerRequestEvent event, Emitter<GetAssignmentAnswerState> emit) async{

    final result =  await getAssignmentAnswerUsecase(GetAssignmentModelAnswersParameters(
      studentId: event.studentId,
      quizId: event.quizId,
    ));

    result.fold(
          (l)=>emit(GetAssignmentAnswerState(
        requestState: RequestState.error,
        responseMessage: l.message,
      )),

          (r)=>emit(GetAssignmentAnswerState(
        getAnswerQuestionResponse: r,
        requestState: RequestState.done,
      )),

    );
  }
}
