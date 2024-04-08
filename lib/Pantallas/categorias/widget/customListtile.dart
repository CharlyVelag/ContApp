// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';

class CustomListTileinfo extends StatelessWidget {
  final String assetImg;
  final String descrip;
  final String cantidad;
  final String image;
  final String fecha;
  const CustomListTileinfo(
      {Key? key,
      required this.assetImg,
      required this.descrip,
      required this.cantidad,
      required this.fecha,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(base64.decode(image))),
        title: Text(descrip,
            style: const TextStyle(fontSize: 14, color: Colors.black)),
        subtitle: Text("\$ $cantidad",
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(fecha, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
