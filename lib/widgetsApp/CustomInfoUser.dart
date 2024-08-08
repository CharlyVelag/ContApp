// ignore_for_file: file_names, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Pantallas/categorias/provider/providerCategorias.dart';

class CustomListTile extends StatelessWidget {
  final String nombre;
  final String img;
  DateTime now = DateTime.now();
  final String totalmes;

  CustomListTile(
      {Key? key,
      required this.nombre,
      required this.img,
      required this.totalmes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ProviderCategoria>(context);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 115,
        decoration: BoxDecoration(
            color: HexColor("#0097B2"),
            borderRadius: BorderRadius.circular(16)),
        child: ListTile(
            leading: CircleAvatar(
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: img.isEmpty
                      ? Image.asset("assets/1.png")
                      : Image.network(
                          img,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/1.png",
                                fit: BoxFit.fitWidth);
                          },
                        ),
                )),
            title: const Text('Hola',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            subtitle: Text(nombre,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
            trailing: Container(
              padding: EdgeInsets.zero,
              width: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Gastos del mes",
                      style: TextStyle(fontSize: 11, color: Colors.white)),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Lottie.asset(
                          'assets/Animatiowallet.json',
                          // controller: _controllerLogo,
                          height: 200,
                          width: 300.0,
                          animate: true,
                          repeat: true,
                        ),
                      ),
                      Text(totalmes,
                          style: const TextStyle(
                              fontSize: 11, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
