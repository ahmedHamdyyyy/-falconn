part of 'tasks_tab_bloc.dart';

abstract class TasksTabEvent extends Equatable {
  const TasksTabEvent();
}

class TaskTabChanged extends TasksTabEvent {
  final int index;

  const TaskTabChanged(this.index);

  @override
  List<Object> get props => [index];
}