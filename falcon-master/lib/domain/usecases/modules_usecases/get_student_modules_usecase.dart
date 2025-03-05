import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetStudentModulesUsecase extends BaseUseCase<List<ModuleEntity>,GetStudentModulesParameters> {

  final ModulesBaseRepo modulesBaseRepo;

  GetStudentModulesUsecase({required this.modulesBaseRepo});

  @override
  Future<Either<Failure, List<ModuleEntity>>> call(
      GetStudentModulesParameters parameters) async {
    return await modulesBaseRepo.getStudentModules(parameters: parameters);
  }

}


class GetStudentModulesParameters extends Equatable {
  final int studentId;

  GetStudentModulesParameters({required this.studentId});

  @override
  List<Object> get props => [studentId];
}