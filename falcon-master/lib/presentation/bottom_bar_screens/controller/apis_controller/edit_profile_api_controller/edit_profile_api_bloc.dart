import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'edit_profile_api_event.dart';
part 'edit_profile_api_state.dart';

class EditProfileApiBloc extends Bloc<EditProfileApiEvent, EditProfileApiState> {

  final EditStudentProfileUsecase editStudentProfileUsecase ;

  EditProfileApiBloc({required this.editStudentProfileUsecase}) : super(EditProfileApiInitial()) {
    on<EditProfileApiResponseEvent>(_EditProfileApiResponse);
  }

  FutureOr<void> _EditProfileApiResponse(EditProfileApiResponseEvent event, Emitter<EditProfileApiState> emit) async{
    final result = await editStudentProfileUsecase(EditStudentProfileParameters(
      studentId: event.id,
      name: event.name,
      phone: event.phone,
      email: event.email,
      password: event.password,
      university: event.university,
      faculty: event.faculty,
      level: event.level,

    ));


    emit(LoadingEditProfileApi());

    result.fold(
      (l)=>emit(EditProfileApiRequestState(
          requestState: RequestState.error,
          responseMessage: l.message,
        )),

      (r)=>emit(EditProfileApiRequestState(
          editProfileEntityResponse: r,
          requestState: RequestState.done,
        ))
    );
  }
}
