part of 'get_universities_bloc.dart';

class GetUniversitiesState extends Equatable {

  final List<UniversityEntity> universitiesResponse;
  final List<CollegeEntity> collegesResponse;
  final List<LevelEntity> levelsResponse;
  final RequestState requestState;
  final String getUniversitiesMessage;
  final String selectedUniversityId;
  final String selectedCollegeId;
  final String selectedLevelId;

  GetUniversitiesState({
    this.universitiesResponse = const [],
    this.collegesResponse = const [],
    this.levelsResponse = const [],
    this.requestState = RequestState.loading,
    this.getUniversitiesMessage = "",
    this.selectedUniversityId = '',
    this.selectedCollegeId = '',
    this.selectedLevelId = '',
  });

  @override
  List<Object> get props => [
    universitiesResponse,
    collegesResponse,
    levelsResponse,
    requestState,
    getUniversitiesMessage,
    selectedUniversityId,
    selectedCollegeId,
    selectedLevelId,
  ];
}


/*

class GetUniversitiesState extends Equatable {

  final List<UniversityEntity> universitiesResponse;
  final RequestState requestState;
  final String getUniversitiesMessage;

  GetUniversitiesState({
    this.universitiesResponse = const [],
    this.requestState = RequestState.loading,
    this.getUniversitiesMessage = "",
  });

  @override
  List<Object> get props => [
        universitiesResponse,
        requestState,
        getUniversitiesMessage,
      ];
}
*/
