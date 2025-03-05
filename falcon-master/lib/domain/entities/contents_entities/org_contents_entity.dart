import 'package:falcon/core/core_exports.dart';

class OrgContentsEntity extends Equatable {
  final List<ContentEntity> videos;
  final List<ContentEntity> quizzes;
  final List<ContentEntity> assignments;
  final List<ContentEntity> material;

  OrgContentsEntity({
   required this.videos,
   required this.quizzes,
   required this.assignments,
   required this.material,
  });

  @override
  List<Object> get props => [videos, quizzes, assignments, material];
}
