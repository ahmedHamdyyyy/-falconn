import 'dart:async';
import 'dart:math';
import 'package:falcon/core/core_exports.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:webview_flutter/webview_flutter.dart';



class VideoPlayerScreen extends StatefulWidget {
  final String link;
  VideoPlayerScreen({required this.link});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  YoutubePlayerController? _controller;
  WebViewController? _webViewController;

  late Timer _timer;
  Offset _currentPosition = Offset(0, 0);
  bool isFullScreen = false;

  List<Offset> _getWatermarkPositions() {
    final screenSize = MediaQuery.of(context).size;
    return [
      Offset(0, screenSize.height/2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.125),

      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(screenSize.width*0.5, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(screenSize.width*0.5, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(screenSize.width*0.5, screenSize.height/2 +(screenSize.height/2)*0.125),


      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.05),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.1),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.15),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.2),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.25),
      // Offset(screenSize.width*0.65, screenSize.height/2 +(screenSize.height/2)*0.05),
      // Offset(screenSize.width*0.65, screenSize.height/2 +(screenSize.height/2)*0.1),
      // Offset(screenSize.width*0.65, screenSize.height/2 +(screenSize.height/2)*0.125),

    ];
  }
  List<Offset> _getWatermarkPositionsAllScreen() {
    final screenSize = MediaQuery.of(context).size;
    return [
      Offset(0, screenSize.height/2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.125),

      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 +(screenSize.height/2)*0.125),


      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 +(screenSize.height/2)*0.125),

      //---------------------------------------------------------------------------------------------------
      Offset(0, screenSize.height),
      Offset(0, screenSize.height -(screenSize.height)*0.2),
      Offset(0, screenSize.height -(screenSize.height)*0.25),

      Offset((screenSize.width)*0.5, screenSize.height -(screenSize.height)*0.2),
      Offset((screenSize.width)*0.5, screenSize.height -(screenSize.height)*0.25),

      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height -(screenSize.height)*0.2),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height -(screenSize.height)*0.25),


      //-------

      Offset(0, 0),
      Offset(0, 0 +(screenSize.height)*0.2),
      Offset(0, 0 +(screenSize.height)*0.25),

      Offset(screenSize.width-(screenSize.width)*0.5, 0 +(screenSize.height)*0.2),
      Offset(screenSize.width-(screenSize.width)*0.5, 0 +(screenSize.height)*0.25),


      Offset(screenSize.width/2-(screenSize.width)*0.2, 0 +(screenSize.height)*0.2),
      Offset(screenSize.width/2-(screenSize.width)*0.2, 0 +(screenSize.height)*0.25),

      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.1),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.15),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.2),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.3),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.4),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.5),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.6),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.7),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.2),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.3),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.5),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.7),


    ];
  }


  // Method to extract YouTube video ID
  String extractYoutubeId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      throw 'Invalid YouTube URL';
    }
  }

  // Toggle full-screen mode
  void toggleFullScreen() {
    _disableScreenRecordingBlock();
    setState(() {
      isFullScreen = !isFullScreen;
    });
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      Future.delayed(Duration(seconds: 4),(){
        _enableScreenRecordingBlock();
      });
    }
  }


  static const platform = MethodChannel('com.falcon_elearning_2024.falcon/usb');
  Future<void> _disableScreenRecordingBlock() async {
    try {
      await platform.invokeMethod('disableScreenRecordingBlock');
    } catch (e) {
      print("Error disabling screen recording block: $e");
    }
  }

  Future<void> _enableScreenRecordingBlock() async {
    try {
      await platform.invokeMethod('enableScreenRecordingBlock');
    } catch (e) {
      print("Error enabling screen recording block: $e");
    }
  }


  @override
  void initState() {
    super.initState();
    _disableScreenRecordingBlock();

    if(widget.link.toLowerCase().contains("www.youtube.com")){
      _controller = YoutubePlayerController.fromVideoId(
        videoId: extractYoutubeId(widget.link),
        autoPlay: true,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,

        ),
      );

    }else{
      toggleFullScreen();
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(
            "${widget.link}?autoplay=true"));

    }
    _startWatermarkAnimation();

    CacheHelper.saveData(key: "lastVideo", value: widget.link);


  }

  // Method to update watermark position
  // Method to update watermark position
  void _startWatermarkAnimation() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        //requestScreenCapturePermission();
        if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
          _currentPosition = _getWatermarkPositions()[Random().nextInt(_getWatermarkPositions().length)];
        }else{
          _currentPosition = _getWatermarkPositionsAllScreen()[Random().nextInt(_getWatermarkPositionsAllScreen().length)];
        }

      });
    });
  }

  @override
  void dispose() {
    // Ensure the device returns to portrait orientation when leaving the screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if(widget.link.toLowerCase().contains("www.youtube.com")){
      _controller!.close();
    }

    _timer.cancel();

    CacheHelper.removeData(key: "lastVideo");

    _enableScreenRecordingBlock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If in full-screen mode, exit full-screen before navigating back
        if (isFullScreen) {
          toggleFullScreen();
          return false; // Prevent immediate back navigation
        }
        return true; // Allow back navigation
      },
      child: Scaffold(
        appBar: (isFullScreen==false )?CustomAppBar(
          context: context,
          title: "",
          arrowColor: ColorManager.white,
          hasArrowBack: true,
          backgroundColor: ColorManager.black,
          elevation: 0,
        ):null,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            (widget.link.toLowerCase().contains("www.youtube.com"))?Center(
              child: YoutubePlayer(
                controller: _controller!,
                aspectRatio: isFullScreen ? MediaQuery.of(context).size.aspectRatio : 16 / 9,
              ),
            )
                :WebViewWidget(controller: _webViewController!),
            Positioned(
              left: _currentPosition.dx,
              top: _currentPosition.dy,
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(context.read<CurrentUserBloc>().userData!.name+" "+context.read<CurrentUserBloc>().userData!.id ,
                  // encryptText(context.read<CurrentUserBloc>().userData!.id,ApiConstants.encryptionKey),
                  style: getBoldStyle(
                      color: Colors.white38,
                      fontSize: FontSize.s12
                  ),
                ),
              ),
            ),
            Positioned(
              right: isFullScreen?AppConstants.wScreen(context)*0.014:AppConstants.wScreen(context)*0.028,
              bottom: widget.link.toLowerCase().contains("www.youtube.com")?isFullScreen?0:AppConstants.hScreen(context)*0.03:AppConstants.hScreen(context)*0.06,
              child: IconButton(
                icon: Icon(
                  widget.link.toLowerCase().contains("www.youtube.com")?Icons.fullscreen:Icons.screen_rotation,//fullscreen_exit
                  color: ColorManager.white,
                  size: widget.link.toLowerCase().contains("www.youtube.com")?isFullScreen?AppSize.s32:AppSize.s26:AppSize.s24,

                ),
                onPressed: toggleFullScreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class VideoPlayerScreen extends StatefulWidget {
  final String link;
  VideoPlayerScreen({required this.link});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late Timer _timer;
  Offset _currentPosition = Offset(0, 0);
  bool isFullScreen = false;

  List<Offset> _getWatermarkPositions() {
    final screenSize = MediaQuery.of(context).size;
    return [
      Offset(0, screenSize.height/2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.125),

      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(screenSize.width*0.5, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(screenSize.width*0.5, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(screenSize.width*0.5, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(screenSize.width*0.5, screenSize.height/2 +(screenSize.height/2)*0.125),


      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.05),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.1),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.15),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.2),
      // Offset(screenSize.width*0.65, screenSize.height/2 -(screenSize.height/2)*0.25),
      // Offset(screenSize.width*0.65, screenSize.height/2 +(screenSize.height/2)*0.05),
      // Offset(screenSize.width*0.65, screenSize.height/2 +(screenSize.height/2)*0.1),
      // Offset(screenSize.width*0.65, screenSize.height/2 +(screenSize.height/2)*0.125),

    ];
  }
  List<Offset> _getWatermarkPositionsAllScreen() {
    final screenSize = MediaQuery.of(context).size;
    return [
      Offset(0, screenSize.height/2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(0, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(0, screenSize.height/2 +(screenSize.height/2)*0.125),

      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(screenSize.width-(screenSize.width)*0.5, screenSize.height/2 +(screenSize.height/2)*0.125),


      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.05),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.1),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.15),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.2),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 -(screenSize.height/2)*0.25),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 +(screenSize.height/2)*0.05),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 +(screenSize.height/2)*0.1),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height/2 +(screenSize.height/2)*0.125),

      //---------------------------------------------------------------------------------------------------
      Offset(0, screenSize.height),
      Offset(0, screenSize.height -(screenSize.height)*0.2),
      Offset(0, screenSize.height -(screenSize.height)*0.25),

      Offset((screenSize.width)*0.5, screenSize.height -(screenSize.height)*0.2),
      Offset((screenSize.width)*0.5, screenSize.height -(screenSize.height)*0.25),

      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height -(screenSize.height)*0.2),
      Offset(screenSize.width/2-(screenSize.width)*0.2, screenSize.height -(screenSize.height)*0.25),


      //-------

      Offset(0, 0),
      Offset(0, 0 +(screenSize.height)*0.2),
      Offset(0, 0 +(screenSize.height)*0.25),

      Offset(screenSize.width-(screenSize.width)*0.5, 0 +(screenSize.height)*0.2),
      Offset(screenSize.width-(screenSize.width)*0.5, 0 +(screenSize.height)*0.25),


      Offset(screenSize.width/2-(screenSize.width)*0.2, 0 +(screenSize.height)*0.2),
      Offset(screenSize.width/2-(screenSize.width)*0.2, 0 +(screenSize.height)*0.25),

      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.1),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.15),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.2),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.3),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.4),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.5),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.6),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.7),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.2),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.3),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.5),
      Offset((screenSize.width)*0.72, screenSize.height -(screenSize.height)*0.7),


    ];
  }


  // Method to extract YouTube video ID
  String extractYoutubeId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      throw 'Invalid YouTube URL';
    }
  }

  // Toggle full-screen mode
  void toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: extractYoutubeId(widget.link),
      autoPlay: true,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,

      ),
    );
    _startWatermarkAnimation();

    CacheHelper.saveData(key: "lastVideo", value: widget.link);

  }

  // Method to update watermark position
  // Method to update watermark position
  void _startWatermarkAnimation() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
          _currentPosition = _getWatermarkPositions()[Random().nextInt(_getWatermarkPositions().length)];
        }else{
          _currentPosition = _getWatermarkPositionsAllScreen()[Random().nextInt(_getWatermarkPositionsAllScreen().length)];
        }

      });
    });
  }

  @override
  void dispose() {
    // Ensure the device returns to portrait orientation when leaving the screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _controller.close();
    _timer.cancel();

    CacheHelper.removeData(key: "lastVideo");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If in full-screen mode, exit full-screen before navigating back
        if (isFullScreen) {
          toggleFullScreen();
          return false; // Prevent immediate back navigation
        }
        return true; // Allow back navigation
      },
      child: Scaffold(
        appBar: (isFullScreen==false )?CustomAppBar(
            context: context,
            title: "",
          arrowColor: ColorManager.white,
          hasArrowBack: true,
          backgroundColor: ColorManager.black,
          elevation: 0,
        ):null,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: YoutubePlayer(
                controller: _controller,
                aspectRatio: isFullScreen ? MediaQuery.of(context).size.aspectRatio : 16 / 9,
              ),
            ),
            Positioned(
              left: _currentPosition.dx,
              top: _currentPosition.dy,
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(context.read<CurrentUserBloc>().userData!.name+" "+context.read<CurrentUserBloc>().userData!.id ,
                  // encryptText(context.read<CurrentUserBloc>().userData!.id,ApiConstants.encryptionKey),
                  style: getBoldStyle(
                      color: Colors.white38,
                      fontSize: FontSize.s12
                  ),
                ),
              ),
            ),
            Positioned(
              right: isFullScreen?AppConstants.wScreen(context)*0.014:AppConstants.wScreen(context)*0.028,
              bottom: isFullScreen?0:AppConstants.hScreen(context)*0.03,
              child: IconButton(
                icon: Icon(
                   Icons.fullscreen,//fullscreen_exit
                  color: ColorManager.white,
                  size: isFullScreen?AppSize.s32:AppSize.s26,

                ),
                onPressed: toggleFullScreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
