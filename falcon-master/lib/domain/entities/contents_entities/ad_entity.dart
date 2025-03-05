import 'package:falcon/core/core_exports.dart';

class AdEntity extends Equatable {
  final String id;
  final String video;

  AdEntity({
    required this.id,
    required this.video,
  });

  @override
  List<Object> get props => [id, video];
}
