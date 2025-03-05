part of 'get_home_data_bloc.dart';

@immutable
sealed class GetHomeDataEvent extends Equatable {
  GetHomeDataEvent();

  @override
  List<Object> get props => [];
}


class GetAdsEvent extends GetHomeDataEvent {
  GetAdsEvent();
  @override
  List<Object> get props => [];


}


class GetLastChaptersEvent extends GetHomeDataEvent {
  GetLastChaptersEvent();
  @override
  List<Object> get props => [];
}


class GetLastModulesEvent extends GetHomeDataEvent {

  final int userId;
  GetLastModulesEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

