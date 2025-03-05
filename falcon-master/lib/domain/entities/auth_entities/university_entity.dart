import 'package:falcon/core/core_exports.dart';

class UniversityEntity extends Equatable {
  final String id;
  final String name;
  final List<CollegeEntity> colleges;

  UniversityEntity({
    required this.id,
    required this.name,
    required this.colleges,
  });

  @override
  List<Object> get props => [id, name, colleges];
}



