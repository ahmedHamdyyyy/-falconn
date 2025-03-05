import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ValidateCodeAndChargeUsecase extends BaseUseCase<ChargeCodeEntity,ValidateCodeAndChargeParameters>{

  final GeneralBaseRepo generalBaseRepo;
  ValidateCodeAndChargeUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, ChargeCodeEntity>> call(ValidateCodeAndChargeParameters parameters) async{
    return  await generalBaseRepo.validateCodeAndCharge(parameters: parameters);
  }

}
class ValidateCodeAndChargeParameters extends Equatable {
  final int studentId;
  final String code;

  ValidateCodeAndChargeParameters({required this.studentId,required this.code});

  @override
  List<Object> get props => [studentId, code];
}