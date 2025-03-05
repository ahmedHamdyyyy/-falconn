part of 'current_user_bloc.dart';

class CurrentUserState extends Equatable {

  final UserEntity? userData;

  const CurrentUserState({this.userData});

  @override
  List<Object?> get props => [userData];
}
