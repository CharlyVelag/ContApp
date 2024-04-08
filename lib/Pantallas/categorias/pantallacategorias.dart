// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Login/login.dart';
import 'package:flutter_application_13/Pantallas/Principal/pantallaprincipal.dart';
import 'package:flutter_application_13/Pantallas/categorias/provider/providerCategorias.dart';
import 'package:flutter_application_13/Pantallas/categorias/widget/cargaview.dart';
import 'package:flutter_application_13/Pantallas/categorias/widget/customappbart.dart';
import 'package:flutter_application_13/Pantallas/categorias/widget/customwidgetAddcompra.dart';
import 'package:flutter_application_13/Pantallas/categorias/widget/listview.dart';
import 'package:flutter_application_13/Pantallas/categorias/widget/widgetcards.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class PantallaCategorias extends StatefulWidget {
  final String assetImg;
  final String categoria;
  final String id;
  final String nombre;
  final String imgUser;
  const PantallaCategorias(
      {Key? key,
      required this.categoria,
      required this.assetImg,
      required this.id,
      required this.nombre,
      required this.imgUser})
      : super(key: key);

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCategoria>(context);
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PantallaPrincipalScreen(
                    nombre: widget.nombre,
                    img: widget.imgUser,
                    id: widget.id))).then((_) => setState(() {
              _.totalWallet();
            }));
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              (!provider.carga && provider.error)
                  ? Column(
                      children: [
                        const Divider(
                          height: 400,
                        ),
                        Text(
                          "Error de conexion",
                          style: TextStyle(
                              color: HexColor("#0097B2"), fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              var dt = DateTime.now();
                              provider.obtenerCategoria(
                                  widget.categoria, widget.id);
                              provider.obtenerDatosCarruselMes(widget.categoria,
                                  widget.id, provider.mesSelect, 0);
                            },
                            child: const Text("Reintentar"))
                      ],
                    )
                  : provider.carga
                      ? SizedBox(
                          height: _size.height,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: _size.height * 0.31, right: 10, left: 10),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                  AnimationCargaInfo(size: _size),
                                ],
                              ),
                            ),
                          ),
                        )
                      : provider.modelSelecmes.isEmpty
                          ? Center(
                              child: Container(
                                width: _size.width - 50,
                                height: 50,
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
                                child: const Center(
                                  child: Text("Sin datos registrados"),
                                ),
                              ),
                            )
                          : CustomListView(
                              assetImg: widget.assetImg,
                              modelViajes: provider.modelSelecmes,
                            ),
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(children: [
                      const Divider(
                        height: 5,
                        color: Colors.transparent,
                      ),
                      Center(
                          child: CustomChip(
                        categoria: widget.categoria,
                        cantidad: provider.modelSelecmes.length,
                        img: widget.assetImg,
                      )),
                      const Divider(
                        endIndent: 50,
                        indent: 50,
                        height: 25,
                      ),
                      CustomAddCompraWidget(
                        categoria: widget.categoria,
                        model: provider.modelSelecmes,
                        img: widget.assetImg,
                        idUser: widget.id,
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.transparent,
                      ),
                      CarruselScreen(
                        categoria: widget.categoria,
                        id: widget.id,
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.transparent,
                      ),
                    ]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
