import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class LoginUsecase extends BaseUseCase<LoginEntity, LoginParameters> {
  final AuthBaseRepo baseAuthRepository;

  LoginUsecase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParameters parameters) async {
    return await baseAuthRepository.getLogin(parameters: parameters);
  }
}

class LoginParameters extends Equatable {
  final String email;
  final String password;

  const LoginParameters({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
