import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/provider/providerAjustes.dart';
import 'package:flutter_application_13/Pantallas/Principal/provider/principalprovider.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/provider/providerregistros.dart';
import 'package:flutter_application_13/Pantallas/categorias/provider/providerCategorias.dart';
import 'package:flutter_application_13/widgetsApp/CustomSplashScreen.dart';
import 'package:provider/provider.dart';

import 'Pantallas/Login/Provider/Providerlogin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProviderLogin()),
          ChangeNotifierProvider(create: (_) => Providerprincipal()),
          ChangeNotifierProvider(create: (_) => ProviderCategoria()),
          ChangeNotifierProvider(create: (_) => ProviderAltasRegistro()),
          ChangeNotifierProvider(create: (_) => ProviderAjustes()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App control',
          home: SplashScreen(),
        ));
  }
}