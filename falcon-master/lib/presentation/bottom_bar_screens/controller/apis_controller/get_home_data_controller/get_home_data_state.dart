part of 'get_home_data_bloc.dart';


class GetHomeDataState extends Equatable {

  final List<AdEntity> adsResponse;
  final RequestState getAdsRequestState;
  final String getAdsMessage;

  final List<LastChapterEntity> lastChaptersResponse;
  final RequestState getLastChaptersRequestState;
  final String getLastChaptersMessage;

  final List<ModuleEntity> modulesResponse;
  final RequestState getModulesRequestState;
  final String getModulesMessage;


  GetHomeDataState({
    this.adsResponse = const[],
    this.getAdsRequestState = RequestState.loading,
    this.getAdsMessage = "",
    this.lastChaptersResponse = const[],
    this.getLastChaptersRequestState = RequestState.loading,
    this.getLastChaptersMessage = "",
    this.modulesResponse = const[],
    this.getModulesRequestState = RequestState.loading,
    this.getModulesMessage = "",
  });

  GetHomeDataState copyWith({
    List<AdEntity>? adsResponse,
    RequestState? getAdsRequestState,
    String? getAdsMessage,

    List<LastChapterEntity>? lastChaptersResponse,
    RequestState? getChaptersRequestState,
    String? getChaptersMessage,

    List<ModuleEntity>? modulesResponse,
    RequestState? getModulesRequestState,
    String? getModulesMessage,
  }) =>
      GetHomeDataState(

        adsResponse: adsResponse ?? this.adsResponse,
        getAdsRequestState: getAdsRequestState ?? this.getAdsRequestState,
        getAdsMessage: getAdsMessage ?? this.getAdsMessage,

        lastChaptersResponse: lastChaptersResponse ?? this.lastChaptersResponse,
        getLastChaptersRequestState: getChaptersRequestState ??
            this.getLastChaptersRequestState,
        getLastChaptersMessage: getChaptersMessage ?? this.getLastChaptersMessage,

        modulesResponse: modulesResponse ?? this.modulesResponse,
        getModulesRequestState: getModulesRequestState ??
            this.getModulesRequestState,
        getModulesMessage: getModulesMessage ?? this.getModulesMessage,
      );


  @override
  List<Object> get props =>
      [
        adsResponse,
        getAdsRequestState,
        getAdsMessage,

        lastChaptersResponse,
        getLastChaptersRequestState,
        getLastChaptersMessage,

        modulesResponse,
        getModulesRequestState,
        getModulesMessage,
      ];
}


