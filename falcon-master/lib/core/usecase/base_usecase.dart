import "package:dartz/dartz.dart";
import "package:falcon/core/core_exports.dart";

abstract class BaseUseCase<Type, Parameters> {
  Future<Either<Failure, Type>> call(Parameters parameters);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object> get props => [];
}
