import 'package:falcon/core/core_exports.dart';

class VideoEntity extends Equatable {
  final int id;
  final int viewCount;

  VideoEntity({
    required this.id,
    required this.viewCount,
  });

  @override
  List<Object> get props => [id, viewCount];
}
