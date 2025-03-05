part of 'register_page_bloc.dart';

@immutable
sealed class RegisterPageEvent extends Equatable {}

class PageChangedEvent extends RegisterPageEvent {
  final int pageIndex;

  PageChangedEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
