part of 'current_user_bloc.dart';

sealed class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();
}

class SaveCurrentUserEvent extends CurrentUserEvent {

  final UserEntity? userData;
  SaveCurrentUserEvent({this.userData});

  @override
  List<Object> get props => [];

}