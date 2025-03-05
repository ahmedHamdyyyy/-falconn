part of 'get_chapters_bloc.dart';

@immutable
sealed class GetChaptersEvent extends Equatable {
  GetChaptersEvent();

  @override
  List<Object> get props => [];
}

class GetChaptersRequestEvent extends GetChaptersEvent {
  final int subjectId;
  final int userId;

  GetChaptersRequestEvent({
    required this.subjectId,
    required this.userId,
  });

  @override
  List<Object> get props => [subjectId, userId];
}
