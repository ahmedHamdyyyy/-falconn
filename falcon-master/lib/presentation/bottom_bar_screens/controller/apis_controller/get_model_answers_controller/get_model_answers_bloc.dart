
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_model_answers_event.dart';
part 'get_model_answers_state.dart';

class GetModelAnswersBloc extends Bloc<GetModelAnswersEvent, GetModelAnswersState> {

  final GetModelAnswerUsecase getModelAnswerUsecase;

  GetModelAnswersBloc({required this.getModelAnswerUsecase}) : super(GetModelAnswersState()) {
    on<GetModelAnswersRequestEvent>(_GetModelAnswersRequest);
  }

  FutureOr<void> _GetModelAnswersRequest(GetModelAnswersRequestEvent event, Emitter<GetModelAnswersState> emit) async{

    final result =  await getModelAnswerUsecase(GetModelAnswersParameters(
      studentId: event.studentId,
      quizId: event.quizId,
    ));


    result.fold(
      (l)=>emit(GetModelAnswersState(
        requestState: RequestState.error,
        responseMessage: l.message,
      )),

      (r)=>emit(GetModelAnswersState(
        getAnswerQuestionResponse: r,
        requestState: RequestState.done,
      )),

    );
  }
}
