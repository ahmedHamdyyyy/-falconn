import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'register_api_event.dart';

part 'register_api_state.dart';

class RegisterApiBloc extends Bloc<RegisterApiEvent, RegisterApiState> {
  final RegisterUsecase registerUseCase;

  RegisterApiBloc({required this.registerUseCase}) : super(RegisterApiInitial()) {
    on<RegisterRequestEvent>(_RegisterRequest);
  }

  double heightNamePercentage = 0.065;
  double heightEmailPercentage = 0.065;
  double heightPhonePercentage = 0.065;
  double heightPasswordPercentage =0.065;
  double heightConfirmPasswordPercentage =0.065;

  String? nameValidation({required String name}) {
    if(name.isEmpty){
      heightNamePercentage = 0.09;
      return "* Name is required";
    }
    heightNamePercentage = 0.065;
    return null;
  }

  String? emailValidation({required String email}) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);

    if(email.isEmpty){
      heightEmailPercentage = 0.09;
      return "* Email is required";
    }
    else if(regex.hasMatch(email)==false){
      heightEmailPercentage = 0.09;
      return "Invalid email";
    }
    heightEmailPercentage =0.065;
    return null;
  }

  String? phoneValidation({required String phone}) {
    if(phone.isEmpty){
      heightPhonePercentage = 0.09;
      return "* Phone is required";
    }
    else if(phone.length<11){
      heightPhonePercentage =0.09;
      return "phone must be at least 11 characters";
    }
    heightPhonePercentage = 0.065;
    return null;
  }

  String? passwordValidation({required String password}) {
    if(password.isEmpty){
      heightPasswordPercentage = 0.09;
      return "* Password is required";
    }
    else if(password.length<6){
      heightPasswordPercentage =0.09;
      return "Password must be at least 6 characters";
    }

    heightPasswordPercentage = 0.065;
    return null;
  }

  String? confPasswordValidation({required String password,required String confPassword}) {
    if(confPassword.isEmpty){
      heightConfirmPasswordPercentage = 0.09;
      return "*Confirm Password is required";
    }
    else if(confPassword.length<6){
      heightConfirmPasswordPercentage =0.09;
      return "Password must be at least 6 characters";
    }
    else if(confPassword != password){
      heightConfirmPasswordPercentage =0.09;
      return "Confirm password must be equal password";
    }
    heightConfirmPasswordPercentage = 0.065;
    return null;
  }



  FutureOr<void> _RegisterRequest(RegisterRequestEvent event, Emitter<RegisterApiState> emit) async {
      emit(RegisterApiRequestState());
      final result = await registerUseCase(
        RegisterParameters(
            name: event.name,
            phone: event.phone,
            email: event.email,
            password: event.password,
            university: event.university,
            faculty: event.faculty,
            level: event.level,
            fcmtoken: event.fcmtoken),
      );

      result.fold(
        (l) => emit(RegisterApiRequestState(
          requestState: RequestState.error,
          RegisterMessage: l.message,
        )),
        (r) => emit(RegisterApiRequestState(
          registerResponse: r,
          requestState: RequestState.done,
          RegisterMessage: r.message,
        )),
      );
  }
}
