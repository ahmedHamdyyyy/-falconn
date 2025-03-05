
import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_questions_event.dart';
part 'get_questions_state.dart';

class GetQuestionsBloc extends Bloc<GetQuestionsEvent, GetQuestionsState> {

  final ShowQuestionsUsecase showQuestionsUsecase;

  GetQuestionsBloc({required this.showQuestionsUsecase}) : super(GetQuestionsState()) {
    on<GetQuestionsRequestEvent>(_GetQuestionsRequest);
  }

  FutureOr<void> _GetQuestionsRequest(GetQuestionsRequestEvent event, Emitter<GetQuestionsState> emit) async{

    final result =  await showQuestionsUsecase(ShowQuestionsParameters(
      quizId: event.quizId,
    ));

    result.fold(
      (l)=>emit(GetQuestionsState(
        requestState: RequestState.error,
        responseMessage: l.message,
      )),

      (r)=>emit(GetQuestionsState(
        getQuestionsResponse: r,
        requestState: RequestState.done,
      )),

    );
  }
}
