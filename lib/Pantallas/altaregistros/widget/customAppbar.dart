// ignore_for_file: file_names, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/providerregistros.dart';

class CustomAppBar extends StatelessWidget {
  final String nombre;
  final String img;
  DateTime now = DateTime.now();

  CustomAppBar({Key? key, required this.nombre, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAltasRegistro>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              colors: <Color>[
                Color(0xff0097B2),
                Color(0xff0E6EC9),
              ],
            ),
            borderRadius: BorderRadius.circular(16)),
        child: ListTile(
            leading: CircleAvatar(
                radius: 30,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(img))),
            title: const Text('Nuevo registro en:',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            subtitle: Text(nombre,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
            trailing: Container(
              padding: EdgeInsets.zero,
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        provider.image = File("NoPath");
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
