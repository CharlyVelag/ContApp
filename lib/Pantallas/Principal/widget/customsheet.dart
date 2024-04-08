import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Login/login.dart';
import 'package:flutter_application_13/Pantallas/categorias/services/operaciones.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../categorias/pantallacategorias.dart';
import '../../categorias/provider/providerCategorias.dart';

class CustomSheetScreen extends StatelessWidget {
  final int identificador;
  final String iduser;
  final String imgUser;
  final String nombre;
  const CustomSheetScreen(
      {Key? key,
      required this.identificador,
      required this.iduser,
      required this.imgUser,
      required this.nombre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCategoria>(context);

    return SizedBox(
      height: 235,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        // ignore: unrelated_type_equality_checks
        child: Operaciones().calcularMes(identificador, context) == "0.00"
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        identificador == 0
                            ? "Comida"
                            : identificador == 1
                                ? "Ropa"
                                : identificador == 2
                                    ? "Viajes"
                                    : identificador == 3
                                        ? "Compras del hogar"
                                        : identificador == 4
                                            ? "Entretenimiento"
                                            : "Otros gastos",
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(MdiIcons.close))
                    ],
                  ),
                  const Divider(indent: 20, endIndent: 20),
                  const Divider(indent: 30, endIndent: 30),
                  const Text("Sin gastos en el mes para esta categoria"),
                  const Divider(indent: 30, endIndent: 30),
                  const Divider(indent: 20, endIndent: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            provider.obtenerCategoria(
                                identificador == 0
                                    ? "Comida"
                                    : identificador == 1
                                        ? "Ropa"
                                        : identificador == 2
                                            ? "Viajes"
                                            : identificador == 3
                                                ? "Gastosdelhogar"
                                                : identificador == 4
                                                    ? "Entretenimiento"
                                                    : "Otros",
                                globalIdUser);
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    PantallaCategorias(
                                      imgUser: imgUser,
                                      nombre: nombre,
                                      categoria: identificador == 0
                                          ? "Comida"
                                          : identificador == 1
                                              ? "Ropa"
                                              : identificador == 2
                                                  ? "Viajes"
                                                  : identificador == 3
                                                      ? "Compras del hogar"
                                                      : identificador == 4
                                                          ? "Entretenimiento"
                                                          : "Otros gastos",
                                      assetImg: identificador == 0
                                          ? "assets/2.png"
                                          : identificador == 1
                                              ? "assets/6.png"
                                              : identificador == 2
                                                  ? "assets/3.png"
                                                  : identificador == 3
                                                      ? "assets/5.png"
                                                      : identificador == 4
                                                          ? "assets/4.png"
                                                          : "assets/7.png",
                                      id: iduser,
                                    )));
                          },
                          child: const Text("Detalles"))
                    ],
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        identificador == 0
                            ? "Comida"
                            : identificador == 1
                                ? "Ropa"
                                : identificador == 2
                                    ? "Viajes"
                                    : identificador == 3
                                        ? "Compras del hogar"
                                        : identificador == 4
                                            ? "Entretenimiento"
                                            : "Otros gastos",
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(MdiIcons.close))
                    ],
                  ),
                  const Divider(indent: 20, endIndent: 20),
                  Text(
                      "Total \$${Operaciones().calcularMes(identificador, context)}"),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Correspondiente al ${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(identificador, context)), identificador)}%",
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                          "del gasto mes \$${Operaciones().totalesMes(context)}",
                          style: const TextStyle(fontSize: 13))
                    ],
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: Colors.grey[300], // Background color
                    valueColor: AlwaysStoppedAnimation<Color>(
                        HexColor("#0097B2")), // Progress color
                    value: double.parse(Operaciones().porcentaje(
                            context,
                            double.parse(Operaciones()
                                .calcularMes(identificador, context)),
                            identificador)) /
                        100, // Set progress to 50%
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            var dt = DateTime.now();
                            provider.mesSelect = dt.month;

                            provider.obtenerCategoria(
                                identificador == 0
                                    ? "Comida"
                                    : identificador == 1
                                        ? "Ropa"
                                        : identificador == 2
                                            ? "Viajes"
                                            : identificador == 3
                                                ? "Gastosdelhogar"
                                                : identificador == 4
                                                    ? "Entretenimiento"
                                                    : "Otros",
                                iduser);
                            provider.obtenerDatosCarruselMes(
                                identificador == 0
                                    ? "Comida"
                                    : identificador == 1
                                        ? "Ropa"
                                        : identificador == 2
                                            ? "Viajes"
                                            : identificador == 3
                                                ? "Gastosdelhogar"
                                                : identificador == 4
                                                    ? "Entretenimiento"
                                                    : "Otros",
                                iduser,
                                dt.month,
                                0);
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    PantallaCategorias(
                                      imgUser: imgUser,
                                      nombre: nombre,
                                      categoria: identificador == 0
                                          ? "Comida"
                                          : identificador == 1
                                              ? "Ropa"
                                              : identificador == 2
                                                  ? "Viajes"
                                                  : identificador == 3
                                                      ? "Compras del hogar"
                                                      : identificador == 4
                                                          ? "Entretenimiento"
                                                          : "Otros gastos",
                                      assetImg: identificador == 0
                                          ? "assets/2.png"
                                          : identificador == 1
                                              ? "assets/6.png"
                                              : identificador == 2
                                                  ? "assets/3.png"
                                                  : identificador == 3
                                                      ? "assets/5.png"
                                                      : identificador == 4
                                                          ? "assets/4.png"
                                                          : "assets/7.png",
                                      id: iduser,
                                    )));
                          },
                          child: const Text("Ver"))
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
