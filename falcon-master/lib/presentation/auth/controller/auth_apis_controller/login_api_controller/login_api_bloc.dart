import 'dart:async';

import 'package:falcon/core/core_exports.dart';

part 'login_api_event.dart';
part 'login_api_state.dart';

class LoginApiBloc extends Bloc<LoginApiEvent, LoginApiState> {

  final LoginUsecase loginUsecase ;

  LoginApiBloc({required this.loginUsecase}) : super(LoginApiInitial()) {

    on<LoginRequestEvent>(_LoginRequest);
  }

  double heightEmailPercentage = 0.065;
  double heightPasswordPercentage =0.065;

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
  
  FutureOr<void> _LoginRequest(LoginRequestEvent event, Emitter<LoginApiState> emit) async{
    if (event.loginFormKey.currentState!.validate()) {
      event.loginFormKey.currentState!.save();

      emit(LoginApiRequestState());
      final result = await loginUsecase(
        LoginParameters(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
            (l)=> emit(LoginApiRequestState(
          requestState: RequestState.error,
          loginMessage: l.message,
        )),

            (r)=> emit(LoginApiRequestState(
          loginResponse: r,
          requestState: RequestState.done,
          loginMessage: r.message,
        )),
      );
    }else{
      emit(LoginApiInitial());
      heightEmailPercentage =0.09;
      heightPasswordPercentage = 0.09;
    }



  }

}
