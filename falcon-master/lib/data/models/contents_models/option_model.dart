import 'package:falcon/core/core_exports.dart';

class OptionModel extends OptionEntity {
  OptionModel(
      {required super.option1,
      required super.option2,
      required super.option3,
      required super.option4
      });

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
    option1: json["choice1"],
    option2: json["choice2"],
    option3: json["choice3"],
    option4: json["choice4"],
  );
}
