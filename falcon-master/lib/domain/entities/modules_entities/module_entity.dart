import 'package:falcon/core/core_exports.dart';

class ModuleEntity extends Equatable {
  final String id;
  final String name;
  final String? image;
  final String? imageUrl;
  final String price;
  final String description;
  final String startDate;
  final String endDate;
  final List<SubjectEntity>? subjects;

  ModuleEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.subjects,
  });

  @override
  List<Object?> get props =>
      [
        id,
        name,
        image,
        imageUrl,
        price,
        description,
        startDate,
        endDate,
        subjects,
      ];
}
