import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_home_data_event.dart';
part 'get_home_data_state.dart';

class GetHomeDataBloc extends Bloc<GetHomeDataEvent, GetHomeDataState> {
  GetHomeDataBloc() : super(GetHomeDataInitial()) {
    on<GetHomeDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
