part of 'delete_account_bloc.dart';


@immutable
sealed class DeleteAccountEvent extends Equatable {}

class DeleteAccountResponseEvent extends DeleteAccountEvent {
  final String studentId;

  DeleteAccountResponseEvent({
    required this.studentId,
  });

  @override
  List<Object?> get props => [studentId];
}
