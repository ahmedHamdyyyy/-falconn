import 'package:falcon/core/core_exports.dart';

class UniversityModel extends UniversityEntity {
  UniversityModel({
    required super.id,
    required super.name,
    required super.colleges,
  });

  factory UniversityModel.fromJson(Map<String,dynamic> json) => UniversityModel(
    id: json['id'],
    name: json['name'],
    colleges: List<CollegeModel>.from(json['colleges'].map((e)=>CollegeModel.fromJson(e))),
  );

}
