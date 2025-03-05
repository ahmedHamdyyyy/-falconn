import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_all_contents_event.dart';
part 'get_all_contents_state.dart';

class GetAllContentsBloc extends Bloc<GetAllContentsEvent, GetAllContentsState> {

  ShowAllContentsUsecase showAllContentsUsecase;
  ShowOrgContentsUsecase showOrgContentsUsecase;

  GetAllContentsBloc({
    required this.showAllContentsUsecase,
    required this.showOrgContentsUsecase,
  }) : super(GetAllContentsState()) {

    on<GetAllContentsRequestEvent>(_getAllContentsRequest);
    on<GetOrgContentsRequestEvent>(_getOrgContentsRequest);
  }

  FutureOr<void> _getAllContentsRequest(GetAllContentsRequestEvent event, Emitter<GetAllContentsState> emit) async{
    final result = await showAllContentsUsecase(ShowAllContentsParameters(userId: event.userId,chapterId: event.chapterId));

    result.fold(
        (l)=>emit(state.copyWith(
          allContentsRequestState: RequestState.error,
          allContentsMessage: l.message,
        )),

        (r)=>emit(state.copyWith(
          allContentResponse: r,
          allContentsRequestState: RequestState.done,
        ))
    );
  }

  FutureOr<void> _getOrgContentsRequest(GetOrgContentsRequestEvent event, Emitter<GetAllContentsState> emit) async{
    final result = await showOrgContentsUsecase(ShowOrgContentsParameters(userId: event.userId,chapterId: event.chapterId));

    result.fold(
        (l)=>emit(state.copyWith(
          orgContentsRequestState: RequestState.error,
          orgContentsMessage: l.message,
        )),

        (r)=>emit(state.copyWith(
          OrgContentResponse: r,
          orgContentsRequestState: RequestState.done,
        ))
    );
  }
}
