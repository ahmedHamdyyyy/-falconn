import 'package:falcon/core/core_exports.dart';

class ChapterEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? img;
  final String? imgUrl;
  final String? course;
  final String? subjectId;

  ChapterEntity({
    required this.id,
    required this.name,
    required this.img,
    required this.imgUrl,
    required this.description,
    required this.course,
    required this.subjectId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        img,
        imgUrl,
        description,
        course,
        subjectId,
      ];
}
