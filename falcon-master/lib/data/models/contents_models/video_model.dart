import 'package:falcon/core/core_exports.dart';

class VideoFileModel extends VideoFileEntity {
  VideoFileModel({
    required super.showVideos,
    required super.showFiles,
  });


  factory VideoFileModel.fromJson(Map<String, dynamic> json) => VideoFileModel(
    showVideos: List<ShowVideoModel>.from(json["videos"].map((e)=>ShowVideoModel.fromJson(e))) ,
    showFiles: List<ShowFileModel>.from(json["files"].map((e)=>ShowFileModel.fromJson(e)) ),
  );
}

//---------------------------------------------------------

class ShowVideoModel extends ShowVideoEntity {
  ShowVideoModel({
    required super.id,
    required super.name,
    required super.iframe,
  });


  factory ShowVideoModel.fromJson(Map<String, dynamic> json) => ShowVideoModel(
    id: json["id"],
    name: json["name"],
    iframe: json["iframe"],
  );
}
//---------------------------------------------------------
class ShowFileModel extends ShowFileEntity {
  ShowFileModel({
    required super.id,
    required super.name,
    required super.file,
  });


  factory ShowFileModel.fromJson(Map<String, dynamic> json) => ShowFileModel(
    id: json["id"],
    name: json["name"],
    file: json["file"],
  );
}
