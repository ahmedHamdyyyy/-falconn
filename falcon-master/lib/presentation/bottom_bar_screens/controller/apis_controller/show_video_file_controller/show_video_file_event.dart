part of 'show_video_file_bloc.dart';

@immutable
sealed class ShowVideoFileEvent extends Equatable {}

class ShowVideoFileRequestEvent extends ShowVideoFileEvent {
  final String contentId;

  ShowVideoFileRequestEvent({
    required this.contentId,
  });

  @override
  List<Object> get props => [contentId];
}
