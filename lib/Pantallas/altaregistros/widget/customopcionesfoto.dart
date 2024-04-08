// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomOpcionesFoto extends StatelessWidget {
  final Future<void> ontapCamera;
  final Future<void> ontapGaleria;

  const CustomOpcionesFoto(
      {Key? key, required this.ontapCamera, required this.ontapGaleria})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                print("camara");
                ontapCamera;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [Text("Camara"), Icon(MdiIcons.cameraOutline)],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                ontapGaleria;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [Text("Galeria"), Icon(MdiIcons.cameraBurst)],
              ),
            ),
          )
        ],
      ),
    );
  }
}
