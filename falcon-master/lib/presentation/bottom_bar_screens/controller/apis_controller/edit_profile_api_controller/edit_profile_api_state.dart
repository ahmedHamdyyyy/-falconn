part of 'edit_profile_api_bloc.dart';

sealed class EditProfileApiState extends Equatable {}


class EditProfileApiInitial extends EditProfileApiState {
  @override
  List<Object> get props => [];
}

class LoadingEditProfileApi extends EditProfileApiState {
  @override
  List<Object> get props => [];
}

class EditProfileApiRequestState extends EditProfileApiState {

  final ProfileEntity? editProfileEntityResponse;
  final RequestState requestState;
  final String responseMessage;

  EditProfileApiRequestState({
    this.editProfileEntityResponse,
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object?> get props =>
      [
        editProfileEntityResponse,
        requestState,
        responseMessage,
      ];
}
