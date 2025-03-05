import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowAllDoctorsUsecase extends BaseUseCase<List<DoctorEntity>,NoParameters> {

  final GeneralBaseRepo generalBaseRepo ;
  ShowAllDoctorsUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(NoParameters parameters) async{
    return await generalBaseRepo.showAllDoctors();
  }


}