// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/altausuarios.dart';
import 'package:flutter_application_13/Pantallas/categorias/model/Modeloviajes.dart';
import 'package:flutter_application_13/Pantallas/categorias/provider/providerCategorias.dart';
import 'package:flutter_application_13/Pantallas/categorias/services/operaciones.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CustomAddCompraWidget extends StatefulWidget {
  final String categoria;
  final List<ModeloCategoria> model;
  final String img;
  final String idUser;
  const CustomAddCompraWidget(
      {Key? key,
      required this.categoria,
      required this.model,
      required this.img,
      required this.idUser})
      : super(key: key);

  @override
  State<CustomAddCompraWidget> createState() => _CustomAddCompraWidgetState();
}

class _CustomAddCompraWidgetState extends State<CustomAddCompraWidget> {
  int yearSaved = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderCategoria>(context);

    return Container(
      width: size.width - 20,
      height: 160,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Color(0xff0097B2),
            Color(0xff0E6EC9),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const Divider(
            endIndent: 80,
            height: 10,
            color: Colors.white,
            indent: 80,
          ),
          Text(
            "Gastos en ${widget.categoria}  \$ ${Operaciones().calcularTotales(widget.model)}",
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            "Total movimientos: ${widget.model.length}",
            style: const TextStyle(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: ElevatedButton(
                onPressed: /* (provider.carga || provider.error)
                    ? null
                    : */
                    () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => PantallaAltaRegistro(
                              categoria: widget.categoria,
                              img: widget.img,
                              iduser: widget.idUser,
                            )),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Nuevo "),
                    Icon(MdiIcons.plusCircleMultipleOutline),
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Por año", style: TextStyle(color: Colors.white)),
              Checkbox(
                  value: provider.valorCheck,
                  onChanged: (v) {
                    provider.valorCheck = v!;
                    provider.obtenerDatosCarruselMes(
                        widget.categoria,
                        widget.idUser,
                        provider.mesSelect,
                        provider.valorCheck ? yearSaved : 0);
                  }),
              SizedBox(
                  width: 75,
                  height: 40,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: Colors.white,
                    enabled: provider.valorCheck,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 4,
                    onChanged: (v) {
                      setState(() {
                        yearSaved = int.parse(v);
                      });
                      provider.yearProvider = v.isEmpty ? 0 : int.parse(v);
                      provider.obtenerDatosCarruselMes(widget.categoria,
                          widget.idUser, provider.mesSelect, int.parse(v));
                    },
                    decoration: InputDecoration(
                        hintText: "2024",
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.5)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        )),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
