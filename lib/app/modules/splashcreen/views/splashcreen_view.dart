import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../../../data/localstorage.dart';
import '../../home/componen/buttomnavigationbar.dart';
import '../../signin/views/signin_view.dart';

class SplashcreenView extends StatefulWidget {
  const SplashcreenView({super.key});

  @override
  _SplashcreenViewState createState() => _SplashcreenViewState();
}

class _SplashcreenViewState extends State<SplashcreenView> {
  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(const Duration(milliseconds: 3400), () {
      setState(() {
        _d = true;
      });
    });
  }

  Future<void> _checkTokenAndNavigate() async {
    bool hasToken = await LocalStorages.hasToken();
    await Future.delayed(const Duration(seconds: 2));
    if (hasToken) {
      _navigateToHomeView();
    } else {
      _navigateToSignInView();
    }
  }

  void _navigateToHomeView() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomeView();
        },
      ),
    );
  }

  void _navigateToSignInView() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return const SigninView();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 1000 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? h / 3
                      : 7,
              width: 20,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                          ? 2
                          : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? h
                  : _c
                      ? 80
                      : 20,
              width: _d
                  ? w
                  : _c
                      ? 800
                      : 20,
              decoration: BoxDecoration(
                color: _b ? Colors.white : Colors.white,
                image: const DecorationImage(
                  image: AssetImage("assets/logo_tech.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                          ? 2
                          : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? h
                  : _c
                      ? 80
                      : 20,
              width: _d
                  ? w
                  : _c
                      ? 200
                      : 20,
              decoration: BoxDecoration(
                color: _b ? Colors.white : Colors.white,
                image: const DecorationImage(
                  image: AssetImage("assets/ic_launcher.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
