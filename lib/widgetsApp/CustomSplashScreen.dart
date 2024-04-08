// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_13/Pantallas/Login/widget/customLogin.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SecondClassState createState() => _SecondClassState();
}

class _SecondClassState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              ThisIsFadeRoute(
                route: PageLoginSistemaSolar(),
              ),
            );
            Timer(
              Duration(milliseconds: 300),
              () {
                if (mounted) {
                  scaleController.reset();
                }
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        if (mounted) {
          scaleController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    scaleController.stop();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(.2),
                            blurRadius: 100,
                            spreadRadius: 10,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/1.png")),
                            color: Colors.white,
                            shape: BoxShape.circle),
                        child: AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (c, child) => Transform.scale(
                            scale: scaleAnimation.value,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor("#0097B2")),
                            ),
                          ),
                        ),
                      )))))
        ]));
  }
}

class ThisFadePageRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget route;

  ThisFadePageRoute({this.page, required this.route})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> animationsec) =>
                page!,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> animationsec,
                    Widget child) =>
                FadeTransition(
                  opacity: animation,
                  child: route,
                ));
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
