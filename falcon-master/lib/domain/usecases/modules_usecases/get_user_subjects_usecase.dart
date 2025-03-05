import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetUserSubjectsUsecase extends BaseUseCase<List<SubjectEntity>,GetUserSubjectsParameters>{

  final ModulesBaseRepo modulesBaseRepo ;
  GetUserSubjectsUsecase({required this.modulesBaseRepo});

  @override
  Future<Either<Failure, List<SubjectEntity>>> call(GetUserSubjectsParameters parameters) async{
    return await modulesBaseRepo.getUserSubjects(parameters: parameters);
  }


}


class GetUserSubjectsParameters extends Equatable {
  final int moduleId;

  GetUserSubjectsParameters({required this.moduleId});

  @override
  List<Object> get props => [moduleId];
}