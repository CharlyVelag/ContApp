// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unnecessary_string_interpolations, avoid_print, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Login/Provider/Providerlogin.dart';
import 'package:flutter_application_13/Pantallas/categorias/provider/providerCategorias.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../Principal/pantallaprincipal.dart';

class InfoCard extends StatefulWidget {
  final String title;
  final String body;
  final Function() onMoreTap;
  final Widget subIcon;

  const InfoCard(
      {required this.title,
      this.body =
          """La información solo sirve como identificador para recolectar la información en la aplicación. \n1.- Inicio de sesion \n2.-Obtención de datos """,
      required this.onMoreTap,
      this.subIcon = const CircleAvatar(
        backgroundColor: Colors.orange,
        radius: 25,
        child: Icon(
          Icons.directions,
          color: Colors.white,
        ),
      ),
      Key? key})
      : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderLogin>(context);
    final pc = Provider.of<ProviderCategoria>(context);

    return Container(
      margin: EdgeInsets.only(top: size.height / 7, right: 15, left: 15),
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 3),
      ], borderRadius: BorderRadius.circular(25.0), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            widget.body,
            textAlign: TextAlign.justify,
            style: TextStyle(color: HexColor("#0097B2"), fontSize: 14),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          widgetCustomTextfied(
              "Nombre", const Icon(MdiIcons.cardAccountDetails), 1),
          const Divider(
            height: 10,
            color: Colors.transparent,
          ),
          widgetCustomTextfied("Email", const Icon(MdiIcons.email), 2),
          const Divider(
            height: 10,
            color: Colors.transparent,
          ),
          Visibility(
              visible: error3.isEmpty ? false : true,
              child: Row(
                children: const [
                  Text(
                    "Al menos 1 letra minuscula, mayuscula, 1 numero y 1 \ncaracter @\$!%*?&",
                    style: TextStyle(fontSize: 10, color: Colors.red),
                  )
                ],
              )),
          const Divider(
            height: 5,
            color: Colors.transparent,
          ),
          widgetCustomTextfied(
              "Contraseña",
              const Icon(
                MdiIcons.formTextboxPassword,
              ),
              3),
          const Divider(
            height: 10,
            color: Colors.transparent,
          ),
          widgetCustomTextfied("Telefono", const Icon(MdiIcons.cellphone), 4),
          const Divider(
            height: 30,
            color: Colors.transparent,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("cancelar")),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (error.isEmpty &&
                      error2.isEmpty &&
                      error3.isEmpty &&
                      error4.isEmpty &&
                      textoUser.text.isNotEmpty &&
                      textoEmail.text.isNotEmpty &&
                      textoPass.text.isNotEmpty &&
                      textotelefono.text.isNotEmpty) {
                    String statusVerificarCorreo = await provider
                        .verificarCorreo(textoEmail.text.toLowerCase());
                    if (statusVerificarCorreo == "Si") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(MdiIcons.informationBoxOutline),
                              Text(
                                "Correo que intenta ingresar ya esta dado de alta",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )));
                    } else if (statusVerificarCorreo == "No") {
                      debugPrint("NOO Hay errores");

                      await provider.insertNuevousuario(
                          textoUser.text,
                          "",
                          textoEmail.text.toLowerCase(),
                          textoPass.text,
                          textotelefono.text,
                          "Correo");

                      if (provider.insert) {
                        await provider.obtenerUser(
                            textoEmail.text, textoPass.text, "Correo");

                        pc.totalgastos(provider.modelUser[0].idUser,);
                        pc.totalgastosMes(provider.modelUser[0].idUser);
                        print("${provider.modelUser[0].idUser}");
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              PantallaPrincipalScreen(
                            nombre: textoUser.text,
                            img: "",
                            id: provider.modelUser[0].idUser,
                          ),
                        ));
                      }
                    } else if (provider.error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(MdiIcons.informationBoxOutline),
                              Text(
                                "Ocurrio un error al intentar registrarte",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )));
                    }
                  } else {
                    debugPrint("Hay errores");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            MdiIcons.informationBoxOutline,
                            color: Colors.white,
                          ),
                          Text(
                            "Error: revisa tus datos",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text("Registrarse")),
          ])
        ],
      ),
    );
  }

  String error = "";
  String error2 = "";
  String error3 = "";
  String error4 = "";
  TextEditingController textoUser = TextEditingController(text: "");
  TextEditingController textoEmail = TextEditingController(text: "");
  TextEditingController textoPass = TextEditingController(text: "");
  TextEditingController textotelefono = TextEditingController(text: "");
  bool verOcultarPass = true;
  Column widgetCustomTextfied(String hintText, Icon icon, int bandera) {
    return Column(
      children: [
        TextField(
          cursorColor: Colors.white,
          obscureText: bandera == 3 ? verOcultarPass : false,
          controller: bandera == 1
              ? textoUser
              : bandera == 2
                  ? textoEmail
                  : bandera == 3
                      ? textoPass
                      : textotelefono,
          onChanged: (v) {
            if (bandera == 1) {
              if (v.length < 9) {
                setState(() {
                  error = "Al menos 8 caracteres";
                });
              } else {
                setState(() {
                  error = "";
                });
              }
            } else if (bandera == 2) {
              debugPrint(v);
              if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                print("Match");
                setState(() {
                  error2 = "";
                });
              } else {
                debugPrint("No Match");
                setState(() {
                  error2 = "correo no valido";
                });
              }
            } else if (bandera == 3) {
              if (v.length < 9) {
                setState(() {
                  error3 = "Al menos 8 caracteres";
                });
              } else {
                if (RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                    .hasMatch(v)) {
                  setState(() {
                    error3 = "";
                  });
                } else {
                  setState(() {
                    error3 = "la constraseña no cumple requisitos";
                  });
                }
              }
            } else {
              if (v.length < 10) {
                setState(() {
                  error4 = "Al menos 10 caracteres";
                });
              } else {
                setState(() {
                  error4 = "";
                });
              }
            }
          },
          keyboardType: bandera == 1
              ? TextInputType.text
              : bandera == 2
                  ? TextInputType.emailAddress
                  : bandera == 3
                      ? TextInputType.text
                      : TextInputType.phone,
          maxLength: bandera == 1
              ? 60
              : bandera == 2
                  ? 60
                  : bandera == 3
                      ? 25
                      : 10,
          decoration: InputDecoration(
            helperText: bandera == 1
                ? error
                : bandera == 2
                    ? error2
                    : bandera == 3
                        ? error3
                        : error4,
            helperStyle: const TextStyle(color: Colors.red),
            prefixIcon: IconButton(
                color: HexColor("#0097B2"),
                onPressed: bandera == 3
                    ? () {
                        setState(() {
                          verOcultarPass = !verOcultarPass;
                        });
                      }
                    : () {},
                icon: bandera == 3
                    ? verOcultarPass
                        ? const Icon(MdiIcons.eye)
                        : icon
                    : icon),
            hintText: hintText,
          ),
        )
      ],
    );
  }
}
