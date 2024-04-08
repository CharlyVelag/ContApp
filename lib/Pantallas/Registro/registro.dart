import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Registro/widget/customwidgetFormulario.dart';
import 'package:flutter_application_13/widgetsApp/islandDinamic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../widgetsApp/islanaux.dart';
import '../Login/Provider/Providerlogin.dart';

class PantallaRegistroScreen extends StatelessWidget {
  const PantallaRegistroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderLogin>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
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
                                  child: Image.asset("assets/1.png"))),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Registro",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: InfoCard(
                    title: "",
                    onMoreTap: () {},
                  ),
                ),
              ),
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
                "Espere",
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
}
