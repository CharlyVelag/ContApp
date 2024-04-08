// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Pantallas/Login/widget/customLogin.dart';

/// CLASS WIDGETS
class RoundedTextField extends StatelessWidget {
  const RoundedTextField(
      {Key? key,
       this.initialValue = "",
      required this.controler,
      this.hintText = "",
      this.hintTextInterior = ""})
      : super(key: key);

  // var
  final String initialValue, hintText, hintTextInterior;
  final TextEditingController controler;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText, style: const TextStyle(color: Colors.white60)),
        const VerticalSpacing(of: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12.0),
              border:
                  Border.all(width: 2, color: Colors.white10.withOpacity(0.1))),
          child: TextField(
            
              style: const TextStyle(color: Colors.white),
              controller: controler,
              decoration: InputDecoration(
                  hintText: hintTextInterior,
                  hintStyle: const TextStyle(color: Colors.white),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none)),
        ),
      ],
    );
  }
}
