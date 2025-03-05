part of 'get_all_contents_bloc.dart';

@immutable
sealed class GetAllContentsEvent extends Equatable {}

class GetAllContentsRequestEvent extends GetAllContentsEvent {
  final int userId;
  final int chapterId;

  GetAllContentsRequestEvent({required this.userId,required this.chapterId});

  @override
  List<Object> get props => [userId,chapterId];
}
class GetOrgContentsRequestEvent extends GetAllContentsEvent {
  final int userId;
  final int  chapterId;

  GetOrgContentsRequestEvent({required this.userId ,required this.chapterId});

  @override
  List<Object> get props => [userId,chapterId];
}
