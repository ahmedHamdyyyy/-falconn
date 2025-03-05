part of 'get_content_by_id_bloc.dart';

@immutable
sealed class GetContentByIdEvent extends Equatable {
  GetContentByIdEvent();

  @override
  List<Object> get props => [];
}

sealed class GetContentByIdRequestEvent extends GetContentByIdEvent {
  final int contentId;
  final int type;

  GetContentByIdRequestEvent({
    required this.contentId,
    required this.type,
  });

  @override
  List<Object> get props => [contentId, type];
}
