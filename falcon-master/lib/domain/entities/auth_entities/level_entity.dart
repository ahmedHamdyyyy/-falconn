
import 'package:falcon/core/core_exports.dart';

class LevelEntity extends Equatable {
  final String id;
  final String name;

  LevelEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}