import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';


class UniversitiesUsecase extends BaseUseCase<List<UniversityEntity>,NoParameters>{

  final AuthBaseRepo baseAuthRepository ;

  UniversitiesUsecase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, List<UniversityEntity>>> call(NoParameters parameters) async{
    return await baseAuthRepository.getUniversities();
  }


}