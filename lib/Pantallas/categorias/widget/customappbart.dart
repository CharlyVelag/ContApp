import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomChip extends StatelessWidget {
  final String categoria;
  final int cantidad;
  final String img;

  const CustomChip({
    Key? key,
    required this.categoria,
    required this.cantidad,
    required this.img,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 40,
        ),
        Chip(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          backgroundColor: HexColor("#0097B2"),
          label: Text(
            categoria,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Badge(
          badgeColor: HexColor("#0097B2"),
          toAnimate: true,
          badgeContent: Text(
            cantidad.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          child: IconButton(
            onPressed: () {},
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(img)),
          ),
        ),
      ],
    );
  }
}
