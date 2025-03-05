import 'package:falcon/core/core_exports.dart';

class CollegeModel extends CollegeEntity {
  CollegeModel({
    required super.id,
    required super.name,
    required super.levels,
  });

  factory CollegeModel.fromJson(Map<String,dynamic> json) => CollegeModel(
    id: json['id'],
    name: json['name'],
    levels: List<LevelModel>.from(json['levels'].map((e)=>LevelModel.fromJson(e))),
  );
}
