part of 'content_tab_bloc.dart';

abstract class ContentTabEvent extends Equatable {
  const ContentTabEvent();
}

class ContentTabChanged extends ContentTabEvent {
  final int index;

  const ContentTabChanged(this.index);

  @override
  List<Object> get props => [index];
}