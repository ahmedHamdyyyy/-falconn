import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class RegisterUsecase extends BaseUseCase<RegisterEntity,RegisterParameters>{

  final AuthBaseRepo baseAuthRepository  ;

  RegisterUsecase({required this.baseAuthRepository});

  @override
  Future<Either< Failure , RegisterEntity>> call(RegisterParameters parameters)async{
    return await baseAuthRepository.getRegister(parameters: parameters);
  }

}

class RegisterParameters extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String university;
  final String faculty;
  final String level;
  final String fcmtoken;


  RegisterParameters({
     required this.name,
     required this.phone,
     required this.email,
     required this.password,
     required this.university,
     required this.faculty,
     required this.level,
     required this.fcmtoken
  });

  @override
  List<Object> get props => [email, password, fcmtoken];

}