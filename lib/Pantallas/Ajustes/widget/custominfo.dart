import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/provider/providerAjustes.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/widget/customFormulario.dart';
import 'package:provider/provider.dart';

String errorCorreo = "";
String errorPass = "";
String errorNum = "";

class CustomTextFieldInfo extends StatefulWidget {
  const CustomTextFieldInfo(
      {Key? key,
      required this.textInfo,
      required this.textTextField,
      required this.id})
      : super(key: key);

  final String textInfo;
  final String textTextField;
  final int id;

  @override
  State<CustomTextFieldInfo> createState() => _CustomTextFieldInfoState();
}

class _CustomTextFieldInfoState extends State<CustomTextFieldInfo> {
  @override
  void initState() {
    widget.id == 1
        ? textNombre.text = widget.textTextField
        : widget.id == 2
            ? textCodigo.text = widget.textTextField
            : widget.id == 3
                ? textCorreo.text = widget.textTextField
                : widget.id == 4
                    ? textPassWord.text = widget.textTextField
                    : textTelefono.text = widget.textTextField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAjustes>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.textInfo),
          TextFormField(
            maxLength: widget.id == 5 ? 10 : null,
            initialValue: widget.textTextField,
            decoration: provider.editable
                ? InputDecoration(
                    helperText: widget.id == 2 || widget.id == 1
                        ? null
                        : widget.id == 3
                            ? errorCorreo.isEmpty
                                ? null
                                : errorCorreo
                            : widget.id == 4
                                ? errorPass.isEmpty
                                    ? null
                                    : errorPass
                                : errorNum,
                    helperStyle: const TextStyle(
                        color: Colors.red, overflow: TextOverflow.clip),
                    suffixIcon: widget.id == 2 || widget.id == 1
                        ? const Icon(Icons.edit_off_outlined)
                        : widget.id == 3 && errorCorreo.isNotEmpty
                            ? const Icon(
                                Icons.error,
                                color: Colors.red,
                              )
                            : widget.id == 4 && errorPass.isNotEmpty
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : widget.id == 5 && errorNum.isNotEmpty
                                    ? const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.edit_attributes,
                                        color: Colors.green,
                                      ))
                : null,
            enabled:
                widget.id == 2 || widget.id == 1 ? false : provider.editable,
            keyboardType:
                widget.id == 5 ? TextInputType.phone : TextInputType.text,
            onChanged: (v) {
              widget.id == 1
                  ? textNombre.text = v
                  : widget.id == 2
                      ? textCodigo.text = v
                      : widget.id == 3
                          ? textCorreo.text = v
                          : widget.id == 4
                              ? textPassWord.text = v
                              : textTelefono.text = v;
              if (widget.id == 3) {
                debugPrint(v);
                if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                  print("Match");
                  setState(() {
                    errorCorreo = "";
                  });
                } else {
                  debugPrint("No Match");
                  setState(() {
                    errorCorreo = "correo no valido";
                  });
                }
              } else if (widget.id == 4) {
                if (v.length < 9) {
                  setState(() {
                    errorPass = "Al menos 8 caracteres";
                  });
                } else {
                  if (RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#&])[A-Za-z\d@$!%*#&]{8,}$')
                      .hasMatch(v)) {
                    setState(() {
                      errorPass = "";
                    });
                  } else {
                    setState(() {
                      errorPass =
                          "la constraseña no cumple requisitos al menos 1 Mayuscula,\n1 minuscula, 1 número y un caracter espacial @\$!%*#&";
                    });
                  }
                }
              } else if (widget.id == 5) {
                if (v.length < 10) {
                  setState(() {
                    errorNum = "Al menos 10 caracteres";
                  });
                } else {
                  if (v.length > 10) {}
                  setState(() {
                    errorNum = "";
                  });
                }
              }
            },
          )
        ],
      ),
    );
  }
}
