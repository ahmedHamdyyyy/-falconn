part of 'get_universities_bloc.dart';

@immutable
sealed class GetUniversitiesEvent extends Equatable {

  GetUniversitiesEvent();

  @override
  List<Object> get props => [];
}

class GetUniversitiesRequestEvent extends GetUniversitiesEvent {


  GetUniversitiesRequestEvent();

  @override
  List<Object> get props => [];
}

class UniversitySelectedEvent extends GetUniversitiesEvent {
  final String universityId;

  UniversitySelectedEvent(this.universityId);

  @override
  List<Object> get props => [universityId];
}

class CollegeSelectedEvent extends GetUniversitiesEvent {
  final String collegeId;

  CollegeSelectedEvent(this.collegeId);

  @override
  List<Object> get props => [collegeId];
}

class LevelSelectedEvent extends GetUniversitiesEvent {
  final String levelId;

  LevelSelectedEvent(this.levelId);

  @override
  List<Object> get props => [levelId];
}