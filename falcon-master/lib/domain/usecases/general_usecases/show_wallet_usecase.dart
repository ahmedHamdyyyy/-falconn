import 'package:dartz/dartz.dart';
import 'package:falcon/core/core_exports.dart';

class ShowWalletUsecase extends BaseUseCase<WalletEntity,ShowWalletParameters>{

  final GeneralBaseRepo generalBaseRepo ;

  ShowWalletUsecase({required this.generalBaseRepo});

  @override
  Future<Either<Failure, WalletEntity>> call(ShowWalletParameters parameters) async{
    return await generalBaseRepo.showWallet(parameters: parameters);
  }


}
class ShowWalletParameters extends Equatable {
  final int studentId;

  ShowWalletParameters({
    required this.studentId,
  });

  @override
  List<Object> get props => [studentId, ];
}
