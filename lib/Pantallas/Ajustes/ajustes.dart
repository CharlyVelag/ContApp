import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/model/modeluser.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/provider/providerAjustes.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/widget/customFormulario.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/widget/custominfo.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../widgetsApp/islandDinamic.dart';

class Ajustes extends StatelessWidget {
  const Ajustes(
      {Key? key,
      required this.nombre,
      required this.imgperfil,
      required this.infouser})
      : super(key: key);
  final String nombre;
  final String imgperfil;
  final List<InfoUser> infouser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderAjustes>(context);
    return WillPopScope(
      onWillPop: () async {
        provider.editable = false;
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Stack(
                children: [
                  Container(
                    color: HexColor("#0097B2"),
                    height: 280,
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              CircleAvatar(
                                  radius: 30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: imgperfil.isEmpty
                                        ? Image.asset("assets/1.png")
                                        : Image.network(
                                            imgperfil,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset("assets/1.png",
                                                  fit: BoxFit.fitWidth);
                                            },
                                          ),
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                nombre,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.editable
                                  ? "Campos habilitados"
                                  : "Editar",
                              style: TextStyle(
                                color: provider.editable
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.editable = !provider.editable;
                                },
                                icon: Icon(
                                  MdiIcons.fileEditOutline,
                                  color: provider.editable
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: provider.editable &&
                              WidgetsBinding
                                      .instance!.window.viewInsets.bottom >
                                  0.0
                          ? -100
                          : provider.editable
                              ? -10
                              : 50,
                      child: provider.carga
                          ? const SizedBox()
                          : CustomeditInformacion(
                              infoUser: provider.infoUsuario)),
                  Visibility(
                      visible: provider.carga,
                      child: loadingappCustomCharly(provider, context))
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              provider.editable
                  ? IconButton(
                      onPressed: () {
                        provider.editable = false;
                          provider.obtUsuario(int.parse(infouser[0].idUser));
                      },
                      icon: Row(children: const [
                        Icon(
                          MdiIcons.accountCancelOutline,
                          size: 30,
                          color: Colors.red,
                        )
                      ]))
                  : const SizedBox(
                      height: 0,
                    ),
              GestureDetector(
                onTap: () {
                  guardarActualizacionInfo(
                      provider.infoUsuario, context, provider);
                },
                child: Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Guardar"),
                        ])),
              ),
            ],
          )),
    );
  }

  SizedBox loadingappCustomCharly(ProviderAjustes p, BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomLoadingAnimation()],
            )
          ],
        ),
      ),
    );
  }

  guardarActualizacionInfo(
      List<InfoUser> info, BuildContext context, ProviderAjustes p) async {
    // ignore: unrelated_type_equality_checks
    if (textCorreo.text == info[0].email &&
        textPassWord.text == info[0].password &&
        textTelefono.text == info[0].telefono) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(MdiIcons.informationBoxOutline),
              Text(
                "No se ah modificado ningun campo",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )));
    } else {
      if (errorCorreo.isEmpty && errorNum.isEmpty && errorPass.isEmpty) {
        String estatus = "";
        if (textCorreo.text == infouser[0].email) {
          estatus = "No";
        } else {
          estatus = await p.verificarCorreo(textCorreo.text);
        }
        if (estatus == "Si") {
          infouser[0].email = textCorreo.text;
          infouser[0].password = textPassWord.text;
          infouser[0].telefono = textTelefono.text;
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
          print(textPassWord.text);
        } else if (estatus == "No") {
          p.actualizarDatos(infouser[0].idUser, textCorreo.text.toLowerCase(),
              textPassWord.text, textTelefono.text);
          p.editable = false;
        } else if (p.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(MdiIcons.informationBoxOutline),
                  Text(
                    "Ocurrio un error al actualizar datos",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(MdiIcons.informationBoxOutline),
                Text(
                  "Existen errores - Verifique su información",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )));
      }
    }
  }
}
