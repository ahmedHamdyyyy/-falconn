import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';


class DeleteAccountUsecase extends BaseUseCase<String, DeleteAccountParameters> {
  final GeneralBaseRepo generalBaseRepo;

  DeleteAccountUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, String>> call(
      DeleteAccountParameters parameters) async {
    return await generalBaseRepo.deleteAccount(parameters: parameters);
  }
}

class DeleteAccountParameters extends Equatable {
  final String studentId;

  DeleteAccountParameters({
    required this.studentId,
  });

  @override
  List<Object> get props => [studentId ];
}
