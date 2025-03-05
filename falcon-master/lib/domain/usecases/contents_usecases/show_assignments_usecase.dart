import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowAssignmentsUsecase extends BaseUseCase<AssignmentEntity,ShowAssignmentsParameters>{

  final ContentsBaseRepo contentsBaseRepo ;

  ShowAssignmentsUsecase({required this.contentsBaseRepo});

  @override
  Future<Either<Failure,AssignmentEntity>> call(ShowAssignmentsParameters parameters) async{
    return await contentsBaseRepo.showAssignmentQuestions(parameters: parameters);
  }

}

class ShowAssignmentsParameters extends Equatable {
  final int assignmentId;

  ShowAssignmentsParameters({required this.assignmentId});

  @override
  List<Object> get props => [assignmentId];
}