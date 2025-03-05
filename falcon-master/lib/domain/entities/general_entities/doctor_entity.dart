import 'package:falcon/core/core_exports.dart';

class DoctorEntity extends Equatable {
  final String id;
  final String name;
  final String? image;
  final String? imageUrl;
  final String? phone;
  final String? description;

  DoctorEntity({
    required this.id,
    required this.image,
    required this.imageUrl,
    required this.name,
    required this.phone,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        imageUrl,
        name,
        phone,
        description,
      ];
}
