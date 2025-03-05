import 'package:falcon/core/core_exports.dart';

class RateEntity extends Equatable {
  final String id;
  final StudentRatingEntity student;
  final SubjectRatingEntity subject;
  final RatingSubjectEntity rating;

  RateEntity({
    required this.id,
    required this.student,
    required this.subject,
    required this.rating,
  });

  @override
  List<Object> get props => [id, subject , rating];
}



//--------------------
class StudentRatingEntity extends Equatable {

  final String id;
  final String name;

  StudentRatingEntity({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

//--------------------
class SubjectRatingEntity extends Equatable {

  final String id;
  final String name;

  SubjectRatingEntity({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

//--------------------
class RatingSubjectEntity extends Equatable {

  final String rate;
  final String comment;

  RatingSubjectEntity({required this.rate, required this.comment});

  @override
  List<Object> get props => [rate, comment];
}