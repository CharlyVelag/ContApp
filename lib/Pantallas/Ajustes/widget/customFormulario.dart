import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/model/modeluser.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/provider/providerAjustes.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/widget/custominfo.dart';
import 'package:provider/provider.dart';

TextEditingController textNombre = TextEditingController();
TextEditingController textCodigo = TextEditingController();
TextEditingController textCorreo = TextEditingController();
TextEditingController textPassWord = TextEditingController();
TextEditingController textTelefono = TextEditingController();

class CustomeditInformacion extends StatelessWidget {
  const CustomeditInformacion({Key? key, required this.infoUser})
      : super(key: key);
  final List<InfoUser> infoUser;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAjustes>(context);

    return Container(
      height: provider.editable ? 510 : 450,
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 150),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 3),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 5,
        ),
        children: [
          CustomTextFieldInfo(
            id: 1,
            textInfo: "Nombre:",
            textTextField: infoUser[0].nombre,
          ),
          CustomTextFieldInfo(
            id: 2,
            textInfo: "Codigo:",
            textTextField: infoUser[0].mailOrFacebookId,
          ),
          CustomTextFieldInfo(
            id: 3,
            textInfo: "Correo:",
            textTextField: infoUser[0].email,
          ),
          CustomTextFieldInfo(
            id: 4,
            textInfo: "Contraseña:",
            textTextField: infoUser[0].password,
          ),
          CustomTextFieldInfo(
            id: 5,
            textInfo: "Num. Telefono:",
            textTextField: infoUser[0].telefono,
          ),
        ],
      ),
    );
  }
}
