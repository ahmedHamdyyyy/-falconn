import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'content_tab_event.dart';
part 'content_tab_state.dart';


class ContentTabBloc extends Bloc<ContentTabEvent, ContentTabState> {
  ContentTabBloc() : super(const ContentTabState(selectedIndex: 0)) {
    on<ContentTabChanged>((event, emit) {
      emit(ContentTabState(selectedIndex: event.index));
    });
  }
}