import 'package:falcon/core/core_exports.dart';

class ContentEntity extends Equatable {
  final String id;
  final String name;
  final String? type;
  final String? timer;
  final String? file;
  final String? iframe;
  final String? numberOfQuestions;
  final String? enddate;
  final int? completed;


  ContentEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.timer,
    required this.file,
    required this.iframe,
    required this.numberOfQuestions,
    required this.enddate,
    required this.completed,
  });

  @override
  List<Object?> get props => [id, type, name,timer,numberOfQuestions,enddate,completed];
}
