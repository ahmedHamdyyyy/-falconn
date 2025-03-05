import 'dart:async';
import 'package:falcon/core/core_exports.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;
  Timer? _fontSizeTimer;
  Timer? _containerSizeTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener(
          (status) async {
            //todo check login before or not
        if (status == AnimationStatus.completed && mounted) {
          Navigator.pushReplacement(context, PageTransition(
            child:  DeveloperModeDetectionScreen(),
            type: PageTransitionType.fade,
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: AppConstants.pageTransition1200),
          ));

          Timer(
            const Duration(milliseconds: 200),
                () {
              if (mounted) {
                _controller.reset();
              }
            },
          );
        }
      },
    );

    animation1 = Tween<double>(begin: 30, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        if (mounted) {
          setState(() {
            _textOpacity = 1.0;
          });
        }
      });

    _controller.forward();

    _fontSizeTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _fontSize = 1.06;
        });
      }
    });

    _containerSizeTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _containerSize = 2;
          _containerOpacity = 1;
        });
      }
    });

    //todo don't forget remove this timer after check login before or not
    // Timer(const Duration(milliseconds: 4000), () {
    //   setState(() {
    //     Navigator.pushReplacement(context, PageTransition(
    //       child: const LoginView(),
    //       type: PageTransitionType.fade,
    //       curve: Curves.fastEaseInToSlowEaseOut,
    //       duration: const Duration(milliseconds: FixedVar.pageTransition1200),
    //     ));
    //   });
    // });

    // Future.delayed(const Duration(milliseconds: 6000), () {
    //   RoutingHelper.navToOnboarding(context);
    //
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fontSizeTimer?.cancel();
    _containerSizeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize*0.95),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: DefaultTextStyle(
                  style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s26),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'BLUE FALCON',
                        speed:const Duration(milliseconds: 120),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    displayFullTextOnTap: false,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 4000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 4000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _width / _containerSize,
                width: _width / _containerSize,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.circular(50),
                  shape: BoxShape.circle,
                ),

                child: Image.asset(
                  AssetsManager.logo,
                  height:_height*0.2,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class PageTransition2 extends PageRouteBuilder {
  final Widget page;

  PageTransition2(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: const Duration(milliseconds: 2000),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: animation,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: 0,
          child: page,
        ),
      );
    },
  );
}

