// ignore_for_file: file_names


import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onpressed;
  // ignore: use_key_in_widget_constructors
  const CustomSocialButton({required this.icon,required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Shadow color
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
            onPressed: onpressed,
            icon: Icon(
              icon,
              color: Colors.white,
            )),
      ),
    );
  }
}
