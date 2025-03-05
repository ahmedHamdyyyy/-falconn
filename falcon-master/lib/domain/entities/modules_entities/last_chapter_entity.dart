import 'package:falcon/core/core_exports.dart';

class LastChapterEntity extends Equatable {
  final String id;
  final String? img;
  final String name;
  final String course;
  final String? subjectName;
  final String? description;

  LastChapterEntity({
    required this.id,
    required this.img,
    required this.name,
    required this.course,
    required this.subjectName,
    required this.description,
  });

  @override
  List<Object?> get props => [id, img, name, course, subjectName,description];
}
