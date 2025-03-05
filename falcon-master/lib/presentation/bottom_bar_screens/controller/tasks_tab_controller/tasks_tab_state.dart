part of 'tasks_tab_bloc.dart';

class TasksTabState extends Equatable {
  final int selectedIndex;

  const TasksTabState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}