part of 'get_all_doctors_bloc.dart';

class GetAllDoctorsState extends Equatable {
  final List<DoctorEntity> getDoctorsResponse;
  final RequestState requestState;
  final String responseMessage;

  GetAllDoctorsState({
    this.getDoctorsResponse = const [],
    this.requestState = RequestState.loading,
    this.responseMessage = "",
  });

  @override
  List<Object> get props => [
        getDoctorsResponse,
        requestState,
        responseMessage,
      ];
}
