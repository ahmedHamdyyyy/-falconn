import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class RequestContentUsecase
    extends BaseUseCase<RequestContentEntity, RequestContentParameters> {
  final GeneralBaseRepo generalBaseRepo;

  RequestContentUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, RequestContentEntity>> call(
      RequestContentParameters parameters) async {
    return await generalBaseRepo.requestContent(parameters: parameters);
  }
}

class RequestContentParameters extends Equatable {
  final String type;
  final String id;
  final String studentid;

  RequestContentParameters({
    required this.type,
    required this.id,
    required this.studentid,
  });

  @override
  List<Object> get props => [type, id, studentid];
}
