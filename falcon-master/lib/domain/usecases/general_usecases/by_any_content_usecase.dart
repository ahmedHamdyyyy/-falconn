import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ByAnyContentUsecase
    extends BaseUseCase<ByContentEntity, ByAnyContentParameters> {
  final GeneralBaseRepo generalBaseRepo;

  ByAnyContentUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, ByContentEntity>> call(
      ByAnyContentParameters parameters) async {
    return await generalBaseRepo.byAnyContent(parameters: parameters);
  }
}

class ByAnyContentParameters extends Equatable {
  final String type;
  final String id;
  final String studentid;
  final String code;

  ByAnyContentParameters({
    required this.type,
    required this.id,
    required this.studentid,
    required this.code,
  });

  @override
  List<Object> get props => [type, id, studentid, code];
}
