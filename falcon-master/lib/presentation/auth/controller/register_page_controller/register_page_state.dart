part of 'register_page_bloc.dart';

@immutable
sealed class RegisterPageState extends Equatable {
  final int currentPage;

  RegisterPageState(this.currentPage);

  @override
  List<Object> get props => [currentPage];

}

//-------------------------


final class RegisterPageInitial extends RegisterPageState {
  RegisterPageInitial() : super(0);
}

//-------------------------

class RegisterPageChangedState extends RegisterPageState {
  RegisterPageChangedState(int currentPage) : super(currentPage);
}


