import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/ajustes.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/provider/providerAjustes.dart';
import 'package:flutter_application_13/Pantallas/Login/widget/customLogin.dart';
import 'package:flutter_application_13/Pantallas/Principal/provider/principalprovider.dart';
import 'package:flutter_application_13/Pantallas/Principal/widget/CustomWidgetGrafica.dart';
import 'package:flutter_application_13/Pantallas/Principal/widget/CustomWidgetcategoria.dart';
import 'package:flutter_application_13/Pantallas/categorias/pantallacategorias.dart';
import 'package:flutter_application_13/Pantallas/categorias/services/operaciones.dart';
import 'package:flutter_application_13/widgetsApp/CustomInfoUser.dart';
import 'package:flutter_application_13/widgetsApp/islanaux.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgetsApp/islandDinamic.dart';
import '../categorias/provider/providerCategorias.dart';

class PantallaPrincipalScreen extends StatefulWidget {
  final String nombre;
  final String img;
  final String id;
  const PantallaPrincipalScreen(
      {Key? key, required this.nombre, required this.img, required this.id})
      : super(key: key);

  @override
  State<PantallaPrincipalScreen> createState() =>
      _PantallaPrincipalScreenState();
}

class _PantallaPrincipalScreenState extends State<PantallaPrincipalScreen>
    with TickerProviderStateMixin {
  // var
  late AnimationController _controllerLogo;

  @override
  void initState() {
    super.initState();
    _controllerLogo = AnimationController(vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      totalWallet();
    });
  }

  @override
  void dispose() {
    _controllerLogo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderCategoria>(context, listen: false);
    final p = Provider.of<Providerprincipal>(context);
    final prov = Provider.of<ProviderAjustes>(context);

    return WillPopScope(
      onWillPop: () async {
        if (p.info) {
          p.info = false;
          p.salir = false;
        } else {
          p.salir = true;
          p.info = false;
        }

        return false;
      },
      child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 115,
                        ),
                        SizedBox(
                          height: 250,
                          child: PieChart(
                            idUser: globalIdUser,
                            imgUser: widget.img,
                            nombre: widget.nombre,
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          endIndent: 10,
                          indent: 10,
                          height: 5,
                        ),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: WidgetCategorias(
                            provider: provider,
                            width: 150,
                            imageHeith: 100,
                            flag: 0,
                            id: widget.id,
                            imgUser: widget.img,
                            nombre: widget.nombre,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                CustomListTile(
                  nombre: widget.nombre,
                  img: widget.img,
                  totalmes: totalWallet(),
                ),
                Positioned(
                    right: 10,
                    top: 72,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            prov.obtUsuario(int.parse(globalIdUser));

                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) => Ajustes(
                                        nombre: widget.nombre,
                                        imgperfil: widget.img,
                                        infouser: prov.infoUsuario,
                                      )),
                            );
                          },
                          icon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            p.info = true;
                            provider.obtenerCategoria("Otros", widget.id);
                            provider.obtenerCategoria("Ropa", widget.id);
                            provider.obtenerCategoria(
                                "Gastosdelhogar", widget.id);
                            provider.obtenerCategoria(
                                "Entretenimiento", widget.id);
                            provider.obtenerCategoria("Viajes", widget.id);
                          },
                          icon: Lottie.asset(
                            'assets/AnimationCuentajson.json',
                            controller: _controllerLogo,
                            height: 200,
                            width: 300.0,
                            animate: true,
                            repeat: true,
                            onLoaded: (composition) {
                              setState(() {
                                _controllerLogo.duration = composition.duration;
                                _controllerLogo.repeat();
                              });
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            p.salir = true;
                          },
                          icon: Lottie.asset(
                            'assets/AnimatioLogout.json',
                            controller: _controllerLogo,
                            height: 200,
                            width: 300.0,
                            animate: true,
                            repeat: true,
                            onLoaded: (composition) {
                              setState(() {
                                _controllerLogo.duration = composition.duration;
                                _controllerLogo.repeat();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                exitToappCustomCharly(p, size, context),
                infogastos(p, size, context)
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
              width: 110,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Facturas"),
                Icon(
                  MdiIcons.fileChart,
                  color: HexColor("#0097B2"),
                )
              ]))),
    );
  }

  SizedBox loadingappCustomCharly(ProviderAjustes p, BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CrearLoader(
        heigth: 200,
        topHeigthPosicion: size.height / 3,
        mostrarLoader: p.carga,
        color: Colors.black,
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Cargando",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomLoadingAnimation()],
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox exitToappCustomCharly(
      Providerprincipal p, Size size, BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CrearLoader(
        mostrarLoader: p.salir,
        heigth: 97,
        topHeigthPosicion: size.height / 2.2,
        color: Colors.black,
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          width: size.width - 100,
          child: Column(
            children: [
              const Text(
                "¿Desea cerrar sesion?",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        p.salir = false;
                      },
                      child: const Text("Cancelar")),
                  TextButton(
                      onPressed: () {
                        p.salir = false;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const PageLoginSistemaSolar()));
                      },
                      child: const Text("Salir")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String totalWallet() {
    return Operaciones().totalesMes(context);
  }

  WillPopScope infogastos(
      Providerprincipal p, Size size, BuildContext context) {
    final provCat = Provider.of<ProviderCategoria>(context);
    return WillPopScope(
      onWillPop: () async {
        p.info = false;
        p.salir = false;
        return false;
      },
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: CrearLoader(
          mostrarLoader: p.info,
          topHeigthPosicion: size.height / 5,
          heigth: 510,
          color: Colors.black.withOpacity(0.9),
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),
            width: size.width - 100,
            child: Column(
              children: [
                const Text(
                  "Despliegue de gastos totales",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    "Gasto total registrado \$${Operaciones().totales(context)}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                WidgetCategorias(
                  provider: provCat,
                  width: size.width / 3.8,
                  imageHeith: 50,
                  color: Colors.black.withOpacity(0.5),
                  flag: 1,
                  id: widget.id,
                  cantidad1:
                      "Comida\n\$${Operaciones().totMesesCategoria(provCat.modelo2)}",
                  cantidad2:
                      "Viajes\n\$${Operaciones().totMesesCategoria(provCat.modelo1)}",
                  cantidad3:
                      "Entretenimiento\n\$${Operaciones().totMesesCategoria(provCat.modelo4)}",
                  cantidad4:
                      "Hogar\n\$${Operaciones().totMesesCategoria(provCat.modelo5)}",
                  cantidad5:
                      "Ropa\n\$${Operaciones().totMesesCategoria(provCat.modelo3)}",
                  cantidad6:
                      "Otros\n\$${Operaciones().totMesesCategoria(provCat.modelo6)}",
                  imgUser: widget.img,
                  nombre: widget.nombre,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          p.info = false;
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: HexColor("#0097B2"),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.all(5.0),
                            child: const Text(
                              "Aceptar",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetCategorias extends StatelessWidget {
  const WidgetCategorias(
      {Key? key,
      required this.provider,
      required this.width,
      this.color,
      required this.flag,
      this.cantidad1,
      this.cantidad2,
      this.cantidad3,
      this.cantidad4,
      this.cantidad5,
      this.cantidad6,
      required this.id,
      required this.imageHeith,
      required this.imgUser,
      required this.nombre})
      : super(key: key);

  final ProviderCategoria provider;
  final double width;
  final double imageHeith;
  final Color? color;
  final int flag;
  final String? cantidad1;
  final String? cantidad2;
  final String? cantidad3;
  final String? cantidad4;
  final String? cantidad5;
  final String? cantidad6;
  final String id;
  final String imgUser;
  final String nombre;
  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCategoria(
              nombre: cantidad1 ?? "Comida",
              w: width,
              img: "assets/2.png",
              imageWidth: imageHeith,
              color: color,
              onTap: () {
                provider.mesSelect = dt.month;
                provider.obtenerCategoria("Comida", id);
                provider.obtenerDatosCarruselMes("Comida", id, dt.month, 0);
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => PantallaCategorias(
                            categoria: "Comida",
                            assetImg: "assets/2.png",
                            id: globalIdUser,
                            imgUser: imgUser,
                            nombre: nombre,
                          )),
                );
              },
            ),
            CustomCategoria(
              nombre: cantidad2 ?? "Viajes",
              w: width,
              imageWidth: imageHeith,
              color: color,
              img: "assets/3.png",
              onTap: () {
                provider.mesSelect = dt.month;
                provider.obtenerCategoria("Viajes", id);
                provider.obtenerDatosCarruselMes("Viajes", id, dt.month, 0);

                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => PantallaCategorias(
                            categoria: "Viajes",
                            assetImg: "assets/3.png",
                            id: globalIdUser,
                            imgUser: imgUser,
                            nombre: nombre,
                          )),
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCategoria(
              nombre: cantidad3 ?? "Entretenimiento",
              w: width,
              imageWidth: imageHeith,
              color: color,
              img: "assets/4.png",
              onTap: () {
                provider.mesSelect = dt.month;
                provider.obtenerCategoria("Entretenimiento", id);
                provider.obtenerDatosCarruselMes(
                    "Entretenimiento", id, dt.month, 0);

                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => PantallaCategorias(
                            categoria: "Entretenimiento",
                            assetImg: "assets/4.png",
                            id: globalIdUser,
                            imgUser: imgUser,
                            nombre: nombre,
                          )),
                );
              },
            ),
            CustomCategoria(
              nombre: cantidad4 ?? "Compras del hogar",
              w: width,
              imageWidth: imageHeith,
              color: color,
              img: "assets/5.png",
              onTap: () {
                provider.mesSelect = dt.month;
                provider.obtenerCategoria("Gastosdelhogar", id);
                provider.obtenerDatosCarruselMes(
                    "Gastosdelhogar", id, dt.month, 0);

                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => PantallaCategorias(
                            categoria: "Compras del hogar",
                            assetImg: "assets/5.png",
                            id: globalIdUser,
                            imgUser: imgUser,
                            nombre: nombre,
                          )),
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCategoria(
              nombre: cantidad5 ?? "Ropa",
              w: width,
              imageWidth: imageHeith,
              color: color,
              img: "assets/6.png",
              onTap: () {
                provider.mesSelect = dt.month;
                provider.obtenerCategoria("Ropa", id);
                provider.obtenerDatosCarruselMes("Ropa", id, dt.month, 0);

                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => PantallaCategorias(
                            categoria: "Ropa",
                            assetImg: "assets/6.png",
                            id: globalIdUser,
                            imgUser: imgUser,
                            nombre: nombre,
                          )),
                );
              },
            ),
            CustomCategoria(
              nombre: cantidad6 ?? "Otros",
              w: width,
              imageWidth: imageHeith,
              color: color,
              img: "assets/7.png",
              onTap: () {
                provider.mesSelect = dt.month;
                provider.obtenerCategoria("Otros", id);
                provider.obtenerDatosCarruselMes("Otros", id, dt.month, 0);

                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => PantallaCategorias(
                            categoria: "Otros",
                            assetImg: "assets/7.png",
                            id: globalIdUser,
                            imgUser: imgUser,
                            nombre: nombre,
                          )),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
/*
IslandinamicScreen(
                    heigth: 97,
                    color: Colors.black,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      width: size.width - 100,
                      child: Column(
                        children: [
                          const Text(
                            "¿Esta seguro que decea cerrar sesión?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {}, child: Text("Cancelar")),
                              TextButton(
                                  onPressed: () {}, child: Text("Salir")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
 */