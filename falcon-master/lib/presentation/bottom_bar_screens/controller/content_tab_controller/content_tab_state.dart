part of 'content_tab_bloc.dart';

class ContentTabState extends Equatable {
  final int selectedIndex;

  const ContentTabState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}