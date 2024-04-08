// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CrearLoader extends StatelessWidget {
  bool mostrarLoader;
  final Widget child;
  final double heigth;
  final Color color;
  final double? topHeigthPosicion;
  CrearLoader(
      {Key? key,
      required this.mostrarLoader,
      required this.child,
      required this.heigth,
      required this.color,
      this.topHeigthPosicion = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: mostrarLoader,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Stack(
            children: [
              Positioned(
                top: topHeigthPosicion,
                left: 50,
                right: 50,
                child: Visibility(
                    visible: mostrarLoader,
                    child: GestureDetector(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 30),
                          curve: Curves.bounceInOut,
                          height: heigth,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: child,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
