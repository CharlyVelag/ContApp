// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/altausuarios.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ValidationTextField extends StatefulWidget {
  const ValidationTextField(
      {this.textEditingController,
      this.validator,
      this.onChanged,
      this.showConfirmation = true,
      Key? key,
      required this.icon,
      required this.hinttext,
      required this.id})
      : super(key: key);
  final bool showConfirmation;
  final void Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final bool Function(String)? validator;
  final IconData icon;
  final String hinttext;
  final int id;
  @override
  State<ValidationTextField> createState() => _ValidationTextFieldState();
}

class _ValidationTextFieldState extends State<ValidationTextField> {
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder buildFocusedBorder() {
      return OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 1.25),
          borderRadius: BorderRadius.circular(10));
    }

    OutlineInputBorder buildEnabledBorder() {
      return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      );
    }

    Icon? buildSuffixIcon() {
      return Icon(widget.icon, color: Colors.green);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      child: TextField(
        controller: widget.id == 2 ? widget.textEditingController : null,
        onChanged: (val) {
          if (widget.id == 1) {
            descrip.text = val;
            widget.textEditingController!.text = val;
          } else if (widget.id == 2) {
            fecha.text = val;
          } else if (widget.id == 3) {
            if (RegExp(r'^([0-9]+\.?[0-9]{0,2})$').hasMatch(val)) {
              cantidad.text = val;
              widget.textEditingController!.text = val;
              print("VAL: " + val);
              print("Controller: " + cantidad.text);
            }
          }
        },
        inputFormatters: widget.id == 3
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ]
            : [],
        textInputAction:
            widget.id == 3 ? TextInputAction.done : TextInputAction.next,
        onTap: widget.id == 2
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
                _selectFecha(context);
              }
            : null,
        keyboardType: widget.id == 3
            ? const TextInputType.numberWithOptions(
                decimal: true,
              )
            : TextInputType.text,
        decoration: InputDecoration(
            hintText: widget.hinttext,
            focusedBorder: buildFocusedBorder(),
            enabledBorder: buildEnabledBorder(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: buildSuffixIcon(),
            prefixIcon: widget.id == 3
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        "\$",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.5), fontSize: 15),
                      )
                    ],
                  )
                : null),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  _selectFecha(BuildContext context) async {
    String dayAux;
    String monthAux;
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );

    if (selected != null && selected != selectedDate)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedDate = selected;
      });
    if (selectedDate.day < 10) {
      // valigación si día es menor a 10 agregar 0
      dayAux = "0${selectedDate.day}";
    } else {
      dayAux = "${selectedDate.day}";
    }
    // valigación si mes es menor a 10 agregar 0
    if (selectedDate.month < 10) {
      monthAux = "0${selectedDate.month}";
    } else {
      monthAux = "${selectedDate.month}";
    }

    setState(() {
      widget.textEditingController!.text =
          '${selectedDate.year}-$monthAux-$dayAux';
      fecha.text = '${selectedDate.year}-$monthAux-$dayAux';
    });
  }
}
