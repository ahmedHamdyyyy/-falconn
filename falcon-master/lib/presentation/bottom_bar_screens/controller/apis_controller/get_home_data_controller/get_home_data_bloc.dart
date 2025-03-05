import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_home_data_event.dart';
part 'get_home_data_state.dart';

class GetHomeDataBloc extends Bloc<GetHomeDataEvent, GetHomeDataState> {

  final GetAdsUsecase getAdsUseCase ;
  final GetLastChaptersUsecase getLastChaptersUsecase ;
  final GetUserModulesUsecase getUserModulesUsecase ;

  GetHomeDataBloc({
    required this.getAdsUseCase,
    required this.getLastChaptersUsecase,
    required this.getUserModulesUsecase,
  }) : super(GetHomeDataState()) {

    on<GetAdsEvent>(_getAdsRequest);
    on<GetLastChaptersEvent>(_getLastChaptersRequest);
    on<GetLastModulesEvent>(_getModulesRequest);
  }


  FutureOr<void> _getAdsRequest(GetAdsEvent event, Emitter<GetHomeDataState> emit) async{

    final result = await getAdsUseCase(NoParameters());

    result.fold(
        (l)=>emit(state.copyWith(
          getAdsRequestState: RequestState.error,
          getAdsMessage: l.message,
        )),

       (r)=>emit(state.copyWith(
          adsResponse: r,
          getAdsRequestState: RequestState.done,
      )),

    );
  }


  FutureOr<void> _getLastChaptersRequest(GetLastChaptersEvent event, Emitter<GetHomeDataState> emit) async{

    final result =  await getLastChaptersUsecase(NoParameters());

    result.fold(
        (l)=>emit(state.copyWith(
          getChaptersRequestState: RequestState.error,
          getChaptersMessage: l.message,
        )),
        (r)=>emit(state.copyWith(
          lastChaptersResponse: r,
          getChaptersRequestState: RequestState.done,
        )),
    );
  }


  FutureOr<void> _getModulesRequest(GetLastModulesEvent event, Emitter<GetHomeDataState> emit) async{
    final result =  await getUserModulesUsecase(GetUserModulesParameters(
      userId: event.userId,
    ));

    result.fold(
        (l)=>emit(state.copyWith(
          getModulesRequestState: RequestState.error,
          getModulesMessage: l.message,
      )),

       (r)=>emit(state.copyWith(
         modulesResponse: r,
         getModulesRequestState: RequestState.done,
      )),

    );
  }
}
