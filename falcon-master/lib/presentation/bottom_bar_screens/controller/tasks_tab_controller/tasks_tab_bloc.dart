import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tasks_tab_event.dart';
part 'tasks_tab_state.dart';

// class TasksTabBloc extends Bloc<TasksTabEvent, TasksTabEvent> {
//   TasksTabBloc() : super(TasksTabInitial()) {
//     on<TasksTabEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

class TasksTabBloc extends Bloc<TasksTabEvent, TasksTabState> {
  TasksTabBloc() : super(const TasksTabState(selectedIndex: 0)) {
    on<TaskTabChanged>((event, emit) {
      emit(TasksTabState(selectedIndex: event.index));
    });
  }
}