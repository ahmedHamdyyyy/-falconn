part of 'get_student_modules_bloc.dart';

class GetStudentModulesState extends Equatable {
  final List<ModuleEntity> modulesResponse;
  final RequestState getModulesRequestState;
  final String getModulesMessage;

  GetStudentModulesState({
    this.modulesResponse = const [],
    this.getModulesRequestState = RequestState.loading,
    this.getModulesMessage = "",
  });

  @override
  List<Object> get props => [
        modulesResponse,
        getModulesRequestState,
        getModulesMessage,
      ];
}
