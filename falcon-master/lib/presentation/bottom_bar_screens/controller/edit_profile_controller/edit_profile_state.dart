part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditNameChanged extends EditProfileState {
  bool canEditName = false ;
  EditNameChanged({required this.canEditName});
}

class EditPhoneChanged extends EditProfileState {
  bool canEditPhone = false;
  EditPhoneChanged({required this.canEditPhone});
}

class EditEmailChanged extends EditProfileState {
  bool canEditEmail = false;
  EditEmailChanged({required this.canEditEmail});
}

class EditUniversityChanged extends EditProfileState {
  String selectedId ;
  EditUniversityChanged({required this.selectedId});
}

class EditFacultyChanged extends EditProfileState {
  String selectedId ;
  EditFacultyChanged({required this.selectedId});
}

class EditLevelChanged extends EditProfileState {
  String selectedId ;
  EditLevelChanged({required this.selectedId});
}

// class EditAvatarChanged extends EditProfileState {
//   bool canEditAvatar = false;
//   EditAvatarChanged({required this.canEditAvatar});
// }
class SuccessEditNameState extends EditProfileState {}
class ErrorEditNameState extends EditProfileState {}
