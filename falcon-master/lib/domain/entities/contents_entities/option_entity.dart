import 'package:falcon/core/core_exports.dart';

class OptionEntity extends Equatable {
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  OptionEntity({
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  @override
  List<Object> get props => [option1, option2, option3, option4];
}
