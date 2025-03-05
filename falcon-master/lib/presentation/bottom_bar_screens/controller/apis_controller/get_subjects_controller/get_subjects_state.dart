part of 'get_subjects_bloc.dart';

class GetSubjectsState extends Equatable {

  final List<SubjectEntity> subjectsResponse;
  final RequestState requestState;
  final String getSubjectsMessage;

  GetSubjectsState({
    this.subjectsResponse = const [],
    this.requestState = RequestState.loading,
    this.getSubjectsMessage = "",
  });

  @override
  List<Object> get props => [
        subjectsResponse,
        requestState,
        getSubjectsMessage,
      ];
}
