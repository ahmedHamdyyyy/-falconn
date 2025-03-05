part of 'get_all_contents_bloc.dart';

class GetAllContentsState extends Equatable {

  final List<ContentEntity> allContentResponse;
  final RequestState allContentsRequestState;
  final String allContentsMessage;

  final OrgContentsEntity? OrgContentResponse;
  final RequestState orgContentsRequestState;
  final String orgContentsMessage;

  GetAllContentsState({

    this.allContentResponse = const[],
    this.allContentsRequestState = RequestState.loading,
    this.allContentsMessage = "",

    this.OrgContentResponse,
    this.orgContentsRequestState = RequestState.loading,
    this.orgContentsMessage = "",
  });

  GetAllContentsState copyWith({
    List<ContentEntity>? allContentResponse,
    RequestState? allContentsRequestState,
    String? allContentsMessage,

    OrgContentsEntity? OrgContentResponse,
    RequestState? orgContentsRequestState,
    String? orgContentsMessage,
  })=>GetAllContentsState(
      allContentResponse:allContentResponse??this.allContentResponse,
      allContentsRequestState:allContentsRequestState??this.allContentsRequestState,
      allContentsMessage:allContentsMessage??this.allContentsMessage,

      OrgContentResponse:OrgContentResponse??this.OrgContentResponse,
      orgContentsRequestState: orgContentsRequestState??this.orgContentsRequestState,
      orgContentsMessage:orgContentsMessage??this.orgContentsMessage,
  );

  @override
  List<Object?> get props =>
      [
        allContentResponse,
        allContentsRequestState,
        allContentsMessage,

        OrgContentResponse,
        orgContentsRequestState,
        orgContentsMessage,
      ];

}
