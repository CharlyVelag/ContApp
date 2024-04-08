// ignore_for_file: unnecessary_string_interpolations, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Login/service/servicios.dart';
import 'package:flutter_application_13/Pantallas/Principal/pantallaprincipal.dart';
import 'package:flutter_application_13/Pantallas/categorias/provider/providerCategorias.dart';
import 'package:flutter_application_13/widgetsApp/CustomSocialMedia.dart';
import 'package:flutter_application_13/widgetsApp/CustomTextField.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgetsApp/islanaux.dart';
import '../../widgetsApp/islandDinamic.dart';
import '../Registro/registro.dart';
import 'Provider/Providerlogin.dart';

var globalkeyIdUserFacebook = "";
var globalKeyNombre = "";
var gloablImageString = "";
var globalIdUser = "";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController textoEmail = TextEditingController(text: "");
TextEditingController textoPass = TextEditingController(text: "");

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderLogin>(context);
    final pc = Provider.of<ProviderCategoria>(context);

    return Scaffold(
        backgroundColor: HexColor("#0097B2"),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 165,
                left: size.width / 16,
                child: Container(
                  width: size.width - 50,
                  height: size.height / 1.8,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(1, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      RoundedTextField(
                        controler: textoEmail,
                        hintText: "Email, usuario, Codigo",
                        hintTextInterior: "example@gmail.com",
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      RoundedTextField(
                        controler: textoPass,
                        hintText: "Email, usuario, Codigo",
                        hintTextInterior: "example@gmail.com",
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (textoEmail.text == "" ||
                                    textoPass.text == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          MdiIcons.informationBoxOutline,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "Campos vacios. Revise la información",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Colors.white,
                                  ));
                                } else {
                                  await provider.obtenerUser(textoEmail.text,
                                      textoPass.text, "Correo");
                                  if (provider.modelUser.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            MdiIcons.informationBoxOutline,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Error: revisa tus datos",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    await pc.totalgastos(
                                        provider.modelUser[0].idUser);
                                    await pc.totalgastosMes(
                                        provider.modelUser[0].idUser);
                                    print("${provider.modelUser[0].idUser}");
                                    provider.carga = false;
                                    textoEmail.text = "";
                                    textoPass.text = "";
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          PantallaPrincipalScreen(
                                        nombre: provider.modelUser[0].nombre,
                                        img: "",
                                        id: provider.modelUser[0].idUser,
                                      ),
                                    ));
                                  }
                                }
                              },
                              child: const Text("Entrar"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.cyan),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(horizontal: 50)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomSocialButton(
                              icon: MdiIcons.facebook,
                              onpressed: () async {
                                FacebookAuth.instance
                                    .login(permissions: [
                                      "public_profile",
                                      "email"
                                    ])
                                    .timeout(const Duration(seconds: 10))
                                    .then((value) {
                                      FacebookAuth.instance
                                          .getUserData()
                                          .then((userData) async {
                                        Map userD = userData;
                                        String img =
                                            userD["picture"]["data"]["url"];
                                        print(userData["id"]);

                                        bool response =
                                            await provider.obtenerUser(
                                                userData["id"],
                                                "",
                                                "redSocial");
                                        setState(() {
                                          globalKeyNombre = userD["name"];

                                          globalkeyIdUserFacebook =
                                              userData["id"];

                                          gloablImageString = img;
                                        });
                                        if (provider.modelUser.isNotEmpty) {
                                          setState(() {
                                            globalIdUser =
                                                provider.modelUser[0].idUser;
                                          });
                                          await pc.totalgastos(globalIdUser);
                                          await pc.totalgastosMes(globalIdUser);
                                          provider.carga = false;

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  PantallaPrincipalScreen(
                                                nombre: globalKeyNombre,
                                                img: img,
                                                id: globalIdUser,
                                              ),
                                            ),
                                          );
                                        } else {
                                          provider.verAlert = true;
                                        }
                                      });
                                    });
                              }),
                          CustomSocialButton(
                              icon: MdiIcons.google, onpressed: () {}),
                          CustomSocialButton(
                              icon: MdiIcons.apple, onpressed: () {})
                        ],
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      InkWell(
                        onTap: () {
                          print("tap registro");
                          provider.carga = false;
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const PantallaRegistroScreen()),
                          );
                        },
                        child: const Text("Registrate aqui",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                                color: Colors.blue)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: size.width / 4,
                child: Container(
                    padding: const EdgeInsets.only(top: 15),
                    width: size.width / 2,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/1.png"))),
              ),
              solicitudregistropCustomCharly(provider, size, context,
                  globalkeyIdUserFacebook, globalKeyNombre, gloablImageString),
              loadingappCustomCharly(provider, context)
            ],
          ),
        ));
  }

  SizedBox loadingappCustomCharly(ProviderLogin p, BuildContext context) {
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

  SizedBox solicitudregistropCustomCharly(ProviderLogin p, Size size,
      BuildContext context, String codigo, String nombre, String img) {
    var contrasena = ServiciosLogin().getRandomString(10);
    final pc = Provider.of<ProviderCategoria>(context);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CrearLoader(
        mostrarLoader: p.verAlert,
        heigth: 350,
        topHeigthPosicion: size.height / 3,
        color: HexColor("#07438B"),
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          width: size.width - 100,
          child: Column(
            children: [
              const Text(
                "Iniciar sesion con facebook",
                style: TextStyle(color: Colors.white),
              ),
              const Divider(
                endIndent: 80,
                indent: 80,
                height: 10,
                color: Colors.white,
              ),
              const Divider(
                endIndent: 50,
                height: 10,
                color: Colors.white,
                indent: 50,
              ),
              const Divider(
                endIndent: 80,
                height: 10,
                color: Colors.white,
                indent: 80,
              ),
              const Text(
                "Tu información almacenada servira como identificador para recolectar tus datos guardados dentro de la aplicación.",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              const Divider(
                endIndent: 80,
                indent: 80,
                height: 10,
                color: Colors.white,
              ),
              const Divider(
                endIndent: 50,
                height: 10,
                color: Colors.white,
                indent: 50,
              ),
              const Text(
                "Importante: toma una captura a la siguiente información en caso de tener detalles de inicio con facebook ingresa el codigo y contraseña para ingresar y no peder tu información.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.justify,
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              Text(
                "Código: $codigo",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                "Contraseña: $contrasena",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const Text(
                "Podras modificarla si lo deceas",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              const Divider(
                endIndent: 80,
                height: 10,
                color: Colors.white,
                indent: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        p.verAlert = false;
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () async {
                        p.verAlert = false;
                        p.carga = false;

                        await p.insertNuevousuario(nombre, codigo, "noregistro",
                            contrasena, "", "Facebook");
                        print("Datos enciados $nombre , $codigo, $contrasena");
                        if (p.insert) {
                          await p.obtenerUser(codigo, "", "redSocial");
                          setState(() {
                            globalIdUser = p.modelUser[0].idUser;
                          });
                          await pc.totalgastos(globalIdUser);
                          await pc.totalgastosMes(p.modelUser[0].idUser);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PantallaPrincipalScreen(
                                nombre: globalKeyNombre,
                                img: img,
                                id: globalIdUser,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Continuar con facebook",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
