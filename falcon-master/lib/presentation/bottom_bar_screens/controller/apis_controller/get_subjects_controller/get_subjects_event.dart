part of 'get_subjects_bloc.dart';

@immutable
sealed class GetSubjectsEvent extends Equatable {
  GetSubjectsEvent();

  @override
  List<Object> get props => [];
}

class GetSubjectsRequestEvent extends GetSubjectsEvent {

  final int moduleId;

  GetSubjectsRequestEvent({required this.moduleId});

  @override
  List<Object> get props => [moduleId];

}


