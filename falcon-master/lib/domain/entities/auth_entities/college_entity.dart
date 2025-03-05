import 'package:falcon/core/core_exports.dart';


class CollegeEntity extends Equatable {
  final String id;
  final String name;
  final List<LevelEntity> levels;

  CollegeEntity({
    required this.id,
    required this.name,
    required this.levels,
  });

  @override
  List<Object> get props => [id, name, levels];
}
