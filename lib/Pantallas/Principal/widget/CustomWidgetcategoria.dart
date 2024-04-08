// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomCategoria extends StatelessWidget {
  final String nombre;
  final String img;
  final double w;
  final double imageWidth;
  final VoidCallback onTap;
  final Color? color;
  DateTime now = DateTime.now();

  CustomCategoria(
      {Key? key,
      required this.nombre,
      required this.img,
      required this.w,
      required this.imageWidth,
      required this.onTap,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: w,
        height: w,
        decoration: BoxDecoration(
            color: color ?? HexColor("#0097B2"),
            borderRadius: BorderRadius.circular(16)),
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        img,
                        height: imageWidth,
                      )),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    nombre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.clip,
                        fontSize: 13),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
