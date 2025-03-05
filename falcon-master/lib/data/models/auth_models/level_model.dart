import 'package:falcon/core/core_exports.dart';

class LevelModel extends LevelEntity {
  LevelModel({
    required super.id,
    required super.name,
  });

  factory LevelModel.fromJson(Map<String,dynamic> json) => LevelModel(
      id: json['id'],
      name: json['name'],
  );
}
