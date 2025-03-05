

import 'package:falcon/core/core_exports.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {

   UserEntity? userData ;

  CurrentUserBloc({this.userData}) : super(CurrentUserState()) {
    on<SaveCurrentUserEvent>((event, emit) {
      userData = event.userData;
    });
  }


}
