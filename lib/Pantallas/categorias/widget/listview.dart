// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/categorias/model/Modeloviajes.dart';
import 'package:flutter_application_13/Pantallas/categorias/widget/customListtile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomListView extends StatelessWidget {
  final String assetImg;
  final List<ModeloCategoria> modelViajes;
  const CustomListView(
      {Key? key, required this.assetImg, required this.modelViajes})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.only(top: _size.height * 0.35, right: 10, left: 10),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: modelViajes.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 2500),
                  child: CustomListTileinfo(
                    assetImg: assetImg,
                    image: modelViajes[index].image,
                    descrip: modelViajes[index].descripcion,
                    cantidad: modelViajes[index].cantidad,
                    fecha: modelViajes[index].fechaPago,
                  )),
            ),
          );
        },
      ),
    );
  }
}
