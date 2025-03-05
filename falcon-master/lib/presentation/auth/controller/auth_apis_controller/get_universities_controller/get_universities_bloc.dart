import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'get_universities_event.dart';
part 'get_universities_state.dart';

class GetUniversitiesBloc extends Bloc<GetUniversitiesEvent, GetUniversitiesState> {

  final UniversitiesUsecase universitiesUsecase;

  GetUniversitiesBloc({required this.universitiesUsecase}) : super(GetUniversitiesState()) {
    on<GetUniversitiesRequestEvent>(_getUniversitiesRequest);
    on<UniversitySelectedEvent>(_onUniversitySelected);
    on<CollegeSelectedEvent>(_onCollegeSelected);
    on<LevelSelectedEvent>(_onLevelSelected); // Add this line
  }

  FutureOr<void> _getUniversitiesRequest(GetUniversitiesRequestEvent event, Emitter<GetUniversitiesState> emit) async {
    final result = await universitiesUsecase(NoParameters());

    result.fold(
          (l) => emit(GetUniversitiesState(
        requestState: RequestState.error,
        getUniversitiesMessage: l.message,
      )),
          (r) => emit(GetUniversitiesState(
        universitiesResponse: r,
        requestState: RequestState.done,
      )),
    );
  }

  FutureOr<void> _onUniversitySelected(UniversitySelectedEvent event, Emitter<GetUniversitiesState> emit) {
    final selectedUniversity = state.universitiesResponse
        .firstWhere((univ) => univ.id == event.universityId);

    emit(GetUniversitiesState(
      universitiesResponse: state.universitiesResponse,
      collegesResponse: selectedUniversity.colleges,
      levelsResponse: [],
      requestState: RequestState.done,
      selectedUniversityId: event.universityId,
    ));
  }

  FutureOr<void> _onCollegeSelected(CollegeSelectedEvent event, Emitter<GetUniversitiesState> emit) {
    final selectedCollege = state.collegesResponse
        .firstWhere((college) => college.id == event.collegeId);

    emit(GetUniversitiesState(
      universitiesResponse: state.universitiesResponse,
      collegesResponse: state.collegesResponse,
      levelsResponse: selectedCollege.levels,
      requestState: RequestState.done,
      selectedUniversityId: state.selectedUniversityId,
      selectedCollegeId: event.collegeId,
    ));
  }

  FutureOr<void> _onLevelSelected(LevelSelectedEvent event, Emitter<GetUniversitiesState> emit) {
    emit(GetUniversitiesState(
      universitiesResponse: state.universitiesResponse,
      collegesResponse: state.collegesResponse,
      levelsResponse: state.levelsResponse,
      requestState: RequestState.done,
      selectedUniversityId: state.selectedUniversityId,
      selectedCollegeId: state.selectedCollegeId,
      selectedLevelId: event.levelId,
    ));
  }
}


/*
class GetUniversitiesBloc extends Bloc<GetUniversitiesEvent, GetUniversitiesState> {

  final UniversitiesUsecase universitiesUsecase ;

  GetUniversitiesBloc({required this.universitiesUsecase}) : super(GetUniversitiesState()) {
    on<GetUniversitiesRequestEvent>(_getUniversitiesRequest);
  }

  FutureOr<void> _getUniversitiesRequest(GetUniversitiesRequestEvent event, Emitter<GetUniversitiesState> emit) async{

    final result = await universitiesUsecase(NoParameters());

    result.fold(
        (l)=> emit(GetUniversitiesState(
          requestState: RequestState.error,
          getUniversitiesMessage: l.message,

        )),

        (r)=> emit(GetUniversitiesState(
          universitiesResponse: r,
          requestState: RequestState.done,
         )),
    );

  }
}
*/
