import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class GetUserModulesUsecase extends BaseUseCase<List<ModuleEntity>,GetUserModulesParameters>{

  final ModulesBaseRepo modulesBaseRepo ;
  GetUserModulesUsecase({required this.modulesBaseRepo});

  @override
  Future<Either<Failure, List<ModuleEntity>>> call(GetUserModulesParameters parameters) async{
    return await modulesBaseRepo.getUserModules(parameters: parameters);
  }

}


class GetUserModulesParameters extends Equatable {
  final int userId;

  GetUserModulesParameters({required this.userId});

  @override
  List<Object> get props => [userId];

}