import 'package:falcon/core/core_exports.dart';

class SubjectEntity extends Equatable {
  final String id;
  final String name;
  final String? image;
  final String? imageUrl;
  final String price;
  final String description;
  final List<DoctorEntity>? doctors;
  final List<ChapterEntity>? chapters;

  SubjectEntity({
    required this.id,
    required this.image,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.doctors,
    required this.chapters,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        imageUrl,
        price,
        description,
        doctors,
        chapters,
      ];
}
