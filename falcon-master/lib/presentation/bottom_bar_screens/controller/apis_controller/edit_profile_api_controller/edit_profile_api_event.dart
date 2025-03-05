part of 'edit_profile_api_bloc.dart';

@immutable
sealed class EditProfileApiEvent extends Equatable {}

class EditProfileApiResponseEvent extends EditProfileApiEvent {
  final int id;
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? university;
  final String? faculty;
  final String? level;

  EditProfileApiResponseEvent({
    required this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.university,
    this.faculty,
    this.level,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        password,
        university,
        faculty,
        level,
      ];
}
