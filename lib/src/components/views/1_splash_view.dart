import 'package:premium_pay_new/export_files.dart';

// ignore: must_be_immutable
class SplashView extends StatefulWidget {
  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  Timer? _timer;
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  


  @override
  void initState() {
    super.initState();

    // 1
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addStatusListener(
        (status) async {
          if (mounted) {
            if (status == AnimationStatus.completed) {
            
            String? token = await CacheService.read(CacheService.token);

             if ((await InternetConnectionChecker().hasConnection)) {
              if (token == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    ThisIsFadeRoute(
                      route: RegisterView(),
                      page: Container(color: Colors.red),
                    ),
                    (r) => false);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    ThisIsFadeRoute(
                      route: ApplicationView(),
                      page: Container(color: Colors.red),
                    ),
                    (r) => false);
              }
              if (_timer != null) {
                _timer?.cancel();
                _timer = null;
              }
            }

            if (_timer == null && !(_timer?.isActive ?? false)) {
              _timer = Timer.periodic(const Duration(seconds: 5), (t) async {
                if ((await InternetConnectionChecker().hasConnection)) {
                  if (token == null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        ThisIsFadeRoute(
                          route: RegisterView(),
                          page: Container(color: Colors.red),
                        ),
                        (r) => false);
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        ThisIsFadeRoute(
                          route: ApplicationView(),
                          page: Container(color: Colors.red),
                        ),
                        (r) => false);
                  }
                  if (_timer != null) {
                    _timer?.cancel();
                    _timer = null;
                  }
                }
              });
            }
            // Navigator.of(context).pushReplacement(
            //   ThisIsFadeRoute(
            //     route: Container(color: Colors.red),
            //     page: Container(color: Colors.red),
            //   ),
            // );
            // Timer(
            //   Duration(milliseconds: 300),
            //   () {
            //     scaleController.reset();
            //   },
            // );
          }
          }
        },
      );

    // 2
    scaleAnimation =
        Tween<double>(begin: 0.0, end: 6).animate(scaleController);

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(Duration(milliseconds: 1800), () {
      setState(() {
        scaleController.forward();
      });
    });

    // Future.delayed(const Duration(seconds: 1), () async {

    // });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: AnimatedOpacity(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(seconds: 6),
                opacity: _opacity,
                child: AnimatedContainer(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(seconds: 2),
                  height: _value ? 50 : 200,
                  width: _value ? 50 : 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0XFFBE52F2).withOpacity(.2),
                        blurRadius: 100,
                        spreadRadius: 10,
                      ),
                    ],
                    color: Colors.transparent,
                    // borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Container(
                      width: 240.w,
                      height: 240.w,
                      
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("assets/logo.png"),)
                      ),
                      child: AnimatedBuilder(
                        animation: scaleAnimation,
                        builder: (c, child) => Transform.scale(
                          scale: scaleAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0XFFBE52F2),
                            ),
                            // child: Image.asset(
                            //   "assets/logo.png",
                            //   width: 240.w,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget route;

  ThisIsFadeRoute({this.page, required this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}
