import 'package:falcon/core/core_exports.dart';

class ServerException  implements Exception {

  final DioException dioException;
  const ServerException({required this.dioException});
}


class LocalDatabaseException  implements Exception {

  final String message;
  const LocalDatabaseException({required this.message});
}