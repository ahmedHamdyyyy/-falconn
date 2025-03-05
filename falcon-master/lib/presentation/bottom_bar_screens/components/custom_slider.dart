import 'dart:async';

import 'package:falcon/core/core_exports.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart' as cSlider;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class CustomAdsSlider extends StatefulWidget {
  @override
  State<CustomAdsSlider> createState() => _CustomAdsSliderState();
}

class _CustomAdsSliderState extends State<CustomAdsSlider> {

  String extractYoutubeId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!; // Return the matched video ID
    } else {
      throw 'Invalid YouTube URL';
    }
  }

  bool _isLoadingVisible = true;

  @override
  void initState() {
    super.initState();

    // Start a timer that will hide the widget after 10 seconds
    Timer(Duration(seconds: 10), () {
      setState(() {
        _isLoadingVisible = false; // Hide the widget after 10 seconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataBloc,GetHomeDataState>(
        buildWhen: (previous, current) =>
        previous.getAdsRequestState != current.getAdsRequestState,
      builder: (context,adsResponseState) {
        if(adsResponseState.getAdsRequestState ==RequestState.loading){
          return Skeletonizer(
            child:Container(
              width: double.infinity,
              height: AppConstants.hScreen(context)*0.22,
              margin: EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r10),
              ),
              child: Image.asset(
                AssetsManager.warningImage,
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        else if(adsResponseState.getAdsRequestState ==RequestState.done ){
          //adsResponseState.adsResponse = [AdEntity(id: "1", video: "https://iframe.mediadelivery.net/play/388972/62aaa1dd-2cfb-4f1f-9356-ed1ed5616f8c")];
          return  (adsResponseState.adsResponse.isEmpty)?SizedBox(
          ):Container(
            width: double.infinity,
            margin:EdgeInsets.only(bottom: AppConstants.hScreen(context)*0.02,),
            child: cSlider.CarouselSlider.builder(
              itemCount: adsResponseState.adsResponse.length,
              itemBuilder: (context, index, realIndex) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: AppConstants.hScreen(context)*0.22,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.r8),

                            child: Stack(
                              children: [
                                _isLoadingVisible?Skeletonizer(
                                  containersColor: ColorManager.lightGrey,
                                  child: Container(
                                    color: ColorManager.lightGrey,
                                    width: double.infinity,
                                    height: AppConstants.hScreen(context)*0.22,
                                  ),
                                ):SizedBox(),
                                SizedBox(
                                  width: double.infinity,
                                  child: (adsResponseState.adsResponse[index].video.toLowerCase().contains("www.youtube.com"))?YoutubePlayer(
                                    enableFullScreenOnVerticalDrag: false,
                                    controller: YoutubePlayerController.fromVideoId(
                                      videoId: extractYoutubeId(adsResponseState.adsResponse[index].video),
                                      autoPlay: false,
                                      params: YoutubePlayerParams(
                                        showControls: true,
                                        showFullscreenButton: true,
                                        mute: true,

                                      ),
                                    ),

                                  )
                                      :WebViewWidget(controller: WebViewController()
                                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                    ..loadRequest(Uri.parse(
                                        "${adsResponseState.adsResponse[index].video}?autoplay=true"))),
                                ),
                              ],
                            ),
                            /*child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  AssetsManager.image_1,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "${adsResponseState.adsResponse[index].video}",
                                  style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s4),
                                ),
                              ],
                            ),*/
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: AppConstants.hScreen(context)*0.22,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, PageTransition(
                                child: VideoPlayerScreen(link:adsResponseState.adsResponse[index].video,),
                                type: PageTransitionType.fade,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                duration: const Duration(milliseconds: AppConstants.pageTransition200),
                              ));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              options: cSlider.CarouselOptions(
                height: AppConstants.hScreen(context)*0.22,
                aspectRatio: 16 / 9,
                viewportFraction: 0.91,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 2500),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          );
        }
        else{
          return GestureDetector(
            onTap: (){
              context.read<GetHomeDataBloc>().add(GetAdsEvent());
            },
            child: Container(
              width: double.infinity,
              height: AppConstants.hScreen(context)*0.22,
              margin: EdgeInsets.symmetric(horizontal: AppPadding.pHScreen4(context)),
              decoration: BoxDecoration(
                color: ColorManager.lightGrey,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.warningImage,
                    height: AppConstants.hScreen(context)*0.05,
                    color: ColorManager.darkGrey.withOpacity(0.6),
                  ),
                  SizedBox(height: AppPadding.pVScreen1(context),),
                  Text(
                    adsResponseState.getAdsMessage,
                    style: getMediumStyle(color: ColorManager.darkGrey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppPadding.pVScreen1(context),),
                  Icon(
                    Icons.refresh,
                    color: ColorManager.darkGrey,
                    size: AppSize.s20,

                  ),

                ],
              ),
            ),
          );

        }
      }
    );
  }
}