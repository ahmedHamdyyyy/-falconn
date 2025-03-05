import 'dart:io';

import 'package:falcon/core/core_exports.dart';
part 'edit_profile_state.dart';

class EditProfileInfoCubit extends Cubit<EditProfileState> {
  EditProfileInfoCubit() : super(EditProfileInitial());

  String? _name;
  String? _phone;
  String? _email;
  bool _canEditName = false;
  bool _canEditPhone = false;
  bool _canEditEmail = false;

  String selectedUniversityId = '';
  String selectedFacultyId = '';
  String selectedLevelId = '';

  void editProfileName({required bool canEditName}) {
    _canEditName = canEditName;

    emit(EditNameChanged(canEditName: canEditName));
  }

  void editProfilePhone({required bool canEditPhone}) {
    _canEditPhone = canEditPhone;

    emit(EditPhoneChanged(canEditPhone: canEditPhone));
  }

  void editProfileEmail({required bool canEditEmail}) {
    _canEditEmail = canEditEmail;

    emit(EditEmailChanged(canEditEmail: canEditEmail));
  }

  void editProfileUniversity({required String selectedId}) {
    selectedUniversityId = selectedId;
    emit(EditUniversityChanged(selectedId: selectedUniversityId));
  }

  void editProfileFaculty({required String selectedId}) {
    selectedFacultyId = selectedId;
    emit(EditUniversityChanged(selectedId: selectedUniversityId));
  }

  void editProfileLevel({required String selectedId}) {
    selectedLevelId = selectedId;
    emit(EditUniversityChanged(selectedId: selectedUniversityId));
  }


  void set setName(newName){
    _name = newName;
  }

  void set setPhone(newPhone){
    _phone = newPhone;
  }

  void set setEmail(newEmail){
    _email = newEmail;
  }

  void saveNewInfo({required BuildContext context ,required String? newName ,required String? newPhone ,required String? newEmail}) {
    if ( true) {
      try{


        emit(SuccessEditNameState());
      }on DioException catch (exception) {
         ApiConstants messageErrorServer = ApiConstants();
        String messageError = messageErrorServer.handelDioException(exception: exception);
        emit(ErrorEditNameState());
      }
    }
  }

  String? get getName => _name;
  String? get getPhone => _phone;
  String? get getEmail => _email;
}
