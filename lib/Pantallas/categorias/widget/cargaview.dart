import 'package:flutter/material.dart';
import '../../Principal/widget/widgetcargaInformacion.dart';

/*
! clase encargada de envolver cada contenedor con animacion y devolverlo a la clase principal
  ? se reciben un parametro obligatorio
    * size -> recibe las dimenciones del dispositivo
    todo: Autor Carlos Alejandro Velasco aguilar
 */
class AnimationCargaInfo extends StatelessWidget {
  const AnimationCargaInfo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width - 40,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const WidgetAnimacionCarga(altura: 50, ancho: 50, radius: 50),
            const VerticalDivider(
              color: Colors.transparent,
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                WidgetAnimacionCarga(
                  altura: 10,
                  ancho: 140,
                  radius: 2,
                ),
                Divider(
                  color: Colors.transparent,
                  height: 5,
                ),
                WidgetAnimacionCarga(altura: 10, ancho: 100, radius: 2),
              ],
            ),
            const VerticalDivider(
              color: Colors.transparent,
              width: 20,
            ),
            const WidgetAnimacionCarga(
              altura: 10,
              ancho: 80,
              radius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
