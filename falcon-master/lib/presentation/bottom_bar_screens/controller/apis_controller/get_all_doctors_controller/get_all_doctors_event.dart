part of 'get_all_doctors_bloc.dart';

@immutable
sealed class GetAllDoctorsEvent extends Equatable {}

class GetAllDoctorsRequestEvent extends GetAllDoctorsEvent {

  GetAllDoctorsRequestEvent();

  @override
  List<Object> get props => [];
}
