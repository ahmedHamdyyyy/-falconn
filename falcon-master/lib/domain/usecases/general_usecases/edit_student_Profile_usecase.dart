import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class EditStudentProfileUsecase extends BaseUseCase<ProfileEntity,EditStudentProfileParameters>{

  final GeneralBaseRepo generalBaseRepo ;

  EditStudentProfileUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, ProfileEntity>> call(EditStudentProfileParameters parameters) async{
    return await generalBaseRepo.editStudentProfile(parameters: parameters);
  }


}


class EditStudentProfileParameters extends Equatable {
  final int studentId;
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? university;
  final String? faculty;
  final String? level;

  EditStudentProfileParameters({
    required this.studentId,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.university,
    this.faculty,
    this.level,
  });

  @override
  List<Object?> get props =>
      [studentId, name, phone, email, password, university, faculty, level,];
}