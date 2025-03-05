import 'package:falcon/core/core_exports.dart';

class RateModel extends RateEntity {
  RateModel({
    required super.id,
    required super.student,
    required super.subject,
    required super.rating,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
        id: json["id"],
        student: StudentRatingModel.fromJson(json["student"]),
        subject:SubjectRatingModel.fromJson(json["subject"]) ,
        rating:RatingSubjectModel.fromJson( json["rating"]),
      );
}


class StudentRatingModel extends StudentRatingEntity {
  StudentRatingModel({
    required super.id,
    required super.name,
  });

  factory StudentRatingModel.fromJson(Map<String, dynamic> json) => StudentRatingModel(
    id: json["id"],
    name: json["name"],
  );
}


class SubjectRatingModel extends SubjectRatingEntity {
  SubjectRatingModel({
    required super.id,
    required super.name,
  });

  factory SubjectRatingModel.fromJson(Map<String, dynamic> json) => SubjectRatingModel(
    id: json["id"],
    name: json["name"],
  );
}

class RatingSubjectModel extends RatingSubjectEntity {
  RatingSubjectModel({
    required super.rate,
    required super.comment,
  });

  factory RatingSubjectModel.fromJson(Map<String, dynamic> json) => RatingSubjectModel(
    rate: json["rate"],
    comment: json["comment"],
  );
}