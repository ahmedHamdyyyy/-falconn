import 'package:falcon/core/core_exports.dart';

class VideoFileEntity extends Equatable {
  final List<ShowVideoEntity> showVideos;
  final List<ShowFileEntity> showFiles;


  VideoFileEntity({
    required this.showVideos,
    required this.showFiles,
  });

  @override
  List<Object> get props => [showVideos, showFiles];
}

//------------------------------------------------
class ShowVideoEntity extends Equatable {

  final String id;
  final String name;
  final String iframe;

  ShowVideoEntity({
    required this.id,
    required this.name,
    required this.iframe,
  });

  @override
  List<Object> get props => [id, name,iframe];

}

//------------------------------------------------
class ShowFileEntity extends Equatable {

  final String id;
  final String name;
  final String file;

  ShowFileEntity({
    required this.id,
    required this.name,
    required this.file,
  });

  @override
  List<Object> get props => [id, name,file];

}

