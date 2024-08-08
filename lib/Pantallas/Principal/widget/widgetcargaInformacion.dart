// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

/*
! clase encargada de contruir y dar animacion a los containers de animacion
  ? se reciben 3 parametros obligatorios
    * altura -> double con la altura que tomara el widget
    * ancho -> double con el ancho que tomamra el widget
    * radius -> double para el radio del widget
 */
class WidgetAnimacionCarga extends StatelessWidget {
  final double altura;
  final double ancho;
  final double radius;
  const WidgetAnimacionCarga(
      {Key? key,
      required this.altura,
      required this.ancho,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: HexColor("#0097B2").withOpacity(0.1),
        highlightColor: const Color(0xff535B61).withOpacity(0.3),
        child: Container(
          height: altura,
          width: ancho,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color(0xff535B61),
              borderRadius: BorderRadius.all(Radius.circular(radius))),
        ),
      );
}
