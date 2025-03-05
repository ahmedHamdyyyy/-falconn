import 'package:falcon/core/core_exports.dart';

class OrgContentsModel extends OrgContentsEntity {
  OrgContentsModel({
    required super.videos,
    required super.quizzes,
    required super.assignments,
    required super.material,
  });

factory OrgContentsModel.fromJson(Map<String, dynamic> json) => OrgContentsModel(

  videos: List<ContentModel>.from(json["videos"].map((e)=> ContentModel.fromJson(e))),
  quizzes: List<ContentModel>.from(json["quizzes"].map((e)=> ContentModel.fromJson(e))),
  assignments: List<ContentModel>.from(json["assignments"].map((e)=> ContentModel.fromJson(e))),
  material: List<ContentModel>.from(json["material"].map((e)=> ContentModel.fromJson(e))),

   );
}
