// ignore_for_file: file_names, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Login/Provider/Providerlogin.dart';
import 'package:flutter_application_13/Pantallas/Login/service/servicios.dart';
import 'package:flutter_application_13/widgetsApp/CustomSocialMedia.dart';
import 'package:flutter_application_13/widgetsApp/islanaux.dart';
import 'package:flutter_application_13/widgetsApp/islandDinamic.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hexcolor/hexcolor.dart';
// Los link de de las depedencias se pueden encontrar en "Más" => Dependencias
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../Principal/pantallaprincipal.dart';
import '../../Registro/registro.dart';
import '../../categorias/provider/providerCategorias.dart';

var globalkeyIdUserFacebook = "";
var globalKeyNombre = "";
var gloablImageString = "";
var globalIdUser = "";

class PageLoginSistemaSolar extends StatefulWidget {
  const PageLoginSistemaSolar({Key? key}) : super(key: key);

  @override
  _PageLoginSistemaSolarState createState() => _PageLoginSistemaSolarState();
}

TextEditingController textoEmail = TextEditingController(text: "");
TextEditingController textoPass = TextEditingController(text: "");

class _PageLoginSistemaSolarState extends State<PageLoginSistemaSolar> {
  // controllers
  late AnimationController animationController;
  // var
  bool isPassword = false;
  String sUser = "", sPass = "";
  bool isDartkTheme = false;
  final Duration _duration = const Duration(seconds: 1);
  late List<Color> lightBgColors, darkBgColors;

  @override
  void initState() {
    DateTime now = DateTime.now();
    print(now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());
    if (now.hour < 18 && now.hour > 6) {
      setState(() {
        isDartkTheme = false;
      });
      print("DIA");
    } else {
      print("NoCHE");
      setState(() {
        isDartkTheme = true;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    //animationController.dispose();
    super.dispose();
  }

  var h = 0;
  @override
  Widget build(BuildContext context) {
    // get
    SizeConfig().init(context);
    //Hora
    var dateTime = DateTime.now();
    h = dateTime.hour;
    // var
    lightBgColors = [
      const Color(0xFF8C2480),
      const Color(0xFFCE587D),
      Colors.blue[600]!,
      Colors.cyan
    ];
    darkBgColors = [
      Colors.black,
      Colors.indigo[800]!.withOpacity(0.2),
      Colors.blue[800]!.withOpacity(0.3)
    ];

    return Scaffold(backgroundColor: Colors.black, body: body());
  }

  /// WIDGETS
  Widget body() {
    var size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderLogin>(context);
    final pc = Provider.of<ProviderCategoria>(context);
    return SafeArea(
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDartkTheme ? darkBgColors : lightBgColors,
          ),
        ),
        child: Stack(
          children: [
            ImgGalaxy(
                duration: const Duration(seconds: 3), isFullSun: isDartkTheme),
            ImgLuna(
                duration: const Duration(seconds: 1), isFullSun: isDartkTheme),
            ImgSol(duration: _duration, isFullSun: isDartkTheme),
            ImgTierra(isDarak: isDartkTheme),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const VerticalSpacing(of: 50.0),
                    /* Tabs(
                        isDartkTheme: isDartkTheme,
                        press: (value) => setState(() {
                              isDartkTheme = value == 0 ? false : true;
                            })),*/
                    const Divider(
                      height: 140,
                      color: Colors.transparent,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      //height: size.height / 2,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            isDartkTheme
                                ? "HOLA ¡Buenas noches!"
                                : "HOLA ¡Buen dia!",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RoundedTextField(
                            controller: textoEmail,
                            hintText: "Email/Codigo",
                            hintTextInterior: "example@gmail.com",
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          RoundedTextField(
                            controller: textoPass,
                            hintText: "Contraseña",
                            hintTextInterior: "*****************",
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (textoEmail.text == "" ||
                                        textoPass.text == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              MdiIcons.informationBoxOutline,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              "Campos vacios. Revise la información",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.white,
                                      ));
                                    } else {
                                      await provider.obtenerUser(
                                          textoEmail.text,
                                          textoPass.text,
                                          "Correo");
                                      if (provider.modelUser.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                MdiIcons.informationBoxOutline,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "Error: revisa tus datos",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Colors.red,
                                        ));
                                        //!Provicional daots navegacion
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const PantallaPrincipalScreen(
                                              nombre: "Paramentro Statico",
                                              img: "",
                                              id: "1",
                                            ),
                                          ),
                                        );
                                      } else {
                                        await pc.totalgastos(
                                            provider.modelUser[0].idUser);
                                        await pc.totalgastosMes(
                                            provider.modelUser[0].idUser);
                                        print(provider.modelUser[0].idUser);
                                        provider.carga = false;
                                        textoEmail.text = "";
                                        textoPass.text = "";
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              PantallaPrincipalScreen(
                                            nombre:
                                                provider.modelUser[0].nombre,
                                            img: "",
                                            id: provider.modelUser[0].idUser,
                                          ),
                                        ));
                                      }
                                    }
                                  },
                                  child: const Text("Entrar"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.cyan),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 50)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.transparent,
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomSocialButton(
                                  icon: MdiIcons.facebook,
                                  onpressed: () async {
                                    //!Provicional daots navegacion
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const PantallaPrincipalScreen(
                                          nombre: "Paramentro Statico",
                                          img: "",
                                          id: "1",
                                        ),
                                      ),
                                    );

                                    FacebookAuth.instance
                                        .login(permissions: [
                                          "public_profile",
                                          "email"
                                        ])
                                        .timeout(const Duration(seconds: 10))
                                        .then((value) {
                                          FacebookAuth.instance
                                              .getUserData()
                                              .then((userData) async {
                                            Map userD = userData;
                                            String img =
                                                userD["picture"]["data"]["url"];
                                            print(userData["id"]);

                                            bool response =
                                                await provider.obtenerUser(
                                                    userData["id"],
                                                    "",
                                                    "redSocial");
                                            setState(() {
                                              globalKeyNombre = userD["name"];

                                              globalkeyIdUserFacebook =
                                                  userData["id"];

                                              gloablImageString = img;
                                            });
                                            if (provider.modelUser.isNotEmpty) {
                                              setState(() {
                                                globalIdUser = provider
                                                    .modelUser[0].idUser;
                                              });
                                              await pc
                                                  .totalgastos(globalIdUser);
                                              await pc
                                                  .totalgastosMes(globalIdUser);
                                              provider.carga = false;

                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext
                                                          context) =>
                                                      PantallaPrincipalScreen(
                                                    nombre: globalKeyNombre,
                                                    img: img,
                                                    id: globalIdUser,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              provider.verAlert = true;
                                            }
                                          });
                                        });
                                  }),
                              CustomSocialButton(
                                  icon: MdiIcons.google,
                                  onpressed: () {
                                    //!Provicional daots navegacion
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const PantallaPrincipalScreen(
                                          nombre: "Paramentro Statico",
                                          img: "",
                                          id: "1",
                                        ),
                                      ),
                                    );
                                  }),
                              CustomSocialButton(
                                  icon: MdiIcons.apple,
                                  onpressed: () {
                                    //!Provicional daots navegacion
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const PantallaPrincipalScreen(
                                          nombre: "Paramentro Statico",
                                          img: "",
                                          id: "1",
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          InkWell(
                            onTap: () {
                              print("tap registro");
                              provider.carga = false;
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const PantallaRegistroScreen()),
                              );
                            },
                            child: const Text(
                              "Registrate aqui",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacing(of: 20.0),
                  ],
                ),
              ),
            ),
            solicitudregistropCustomCharly(provider, size, context,
                globalkeyIdUserFacebook, globalKeyNombre, gloablImageString),
            loadingappCustomCharly(provider, context)
          ],
        ),
      ),
    );
  }

  SizedBox loadingappCustomCharly(ProviderLogin p, BuildContext context) {
    final proCat = Provider.of<ProviderCategoria>(context);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CrearLoader(
        heigth: 200,
        topHeigthPosicion: size.height / 3,
        mostrarLoader: p.carga || proCat.carga,
        color: Colors.black,
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                p.carga ? "Validando usuario" : "Cargando información",
                style: const TextStyle(color: Colors.white),
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

  SizedBox solicitudregistropCustomCharly(ProviderLogin p, Size size,
      BuildContext context, String codigo, String nombre, String img) {
    var contrasena = ServiciosLogin().getRandomString(10);
    final pc = Provider.of<ProviderCategoria>(context);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CrearLoader(
        mostrarLoader: p.verAlert,
        heigth: 350,
        topHeigthPosicion: size.height / 3,
        color: HexColor("#07438B"),
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          width: size.width - 100,
          child: Column(
            children: [
              const Text(
                "Iniciar sesion con facebook",
                style: TextStyle(color: Colors.white),
              ),
              const Divider(
                endIndent: 80,
                indent: 80,
                height: 10,
                color: Colors.white,
              ),
              const Divider(
                endIndent: 50,
                height: 10,
                color: Colors.white,
                indent: 50,
              ),
              const Divider(
                endIndent: 80,
                height: 10,
                color: Colors.white,
                indent: 80,
              ),
              const Text(
                "Tu información almacenada servira como identificador para recolectar tus datos guardados dentro de la aplicación.",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              const Divider(
                endIndent: 80,
                indent: 80,
                height: 10,
                color: Colors.white,
              ),
              const Divider(
                endIndent: 50,
                height: 10,
                color: Colors.white,
                indent: 50,
              ),
              const Text(
                "Importante: toma una captura a la siguiente información en caso de tener detalles de inicio con facebook ingresa el codigo y contraseña para ingresar y no peder tu información.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.justify,
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              Text(
                "Código: $codigo",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                "Contraseña: $contrasena",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const Text(
                "Podras modificarla si lo deceas",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              const Divider(
                endIndent: 80,
                height: 10,
                color: Colors.white,
                indent: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        p.verAlert = false;
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () async {
                        p.verAlert = false;
                        p.carga = false;

                        await p.insertNuevousuario(nombre, codigo, "noregistro",
                            contrasena, "", "Facebook");
                        print("Datos enciados $nombre , $codigo, $contrasena");
                        if (p.insert) {
                          await p.obtenerUser(codigo, "", "redSocial");
                          setState(() {
                            globalIdUser = p.modelUser[0].idUser;
                          });
                          await pc.totalgastos(globalIdUser);
                          await pc.totalgastosMes(p.modelUser[0].idUser);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PantallaPrincipalScreen(
                                nombre: globalKeyNombre,
                                img: img,
                                id: globalIdUser,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Continuar con facebook",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// WIDGETS COMPONENTS
  Widget buttonRound(
      {required void Function()? onPressed,
      required String text,
      IconData? iconData,
      Color colorButton = Colors.white,
      Color colorText = Colors.white,
      Color? colorBorder}) {
    colorBorder ??= colorButton;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        //foregroundColor: Colors.black,
        // backgroundColor: colorButton,
        elevation: 0.0,
        padding: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: colorBorder)),
      ),
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
              color: colorText, fontSize: 16.0, fontWeight: FontWeight.bold)),
    );
  }
}

/// CLASS WIDGETS
class RoundedTextField extends StatefulWidget {
  const RoundedTextField(
      {Key? key,
      this.hintText = "",
      this.hintTextInterior = "",
      required this.controller})
      : super(key: key);

  // var
  final String hintText, hintTextInterior;
  final TextEditingController controller;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

bool pass = true;

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.hintText, style: const TextStyle(color: Colors.white60)),
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
              controller: widget.controller,
              obscureText:
                  widget.hintText == "Contraseña" && pass ? true : false,
              decoration: InputDecoration(
                  suffixIcon: widget.hintText == "Contraseña"
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              pass = !pass;
                            });
                          },
                          icon: pass
                              ? Icon(
                                  MdiIcons.eyeLock,
                                  color: HexColor("#0097B2"),
                                )
                              : Icon(
                                  MdiIcons.eyeLockOpen,
                                  color: HexColor("#0097B2"),
                                ),
                        )
                      : null,
                  hintText: widget.hintTextInterior,
                  hintStyle: const TextStyle(color: Colors.white),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none)),
        ),
      ],
    );
  }
}

class Tabs extends StatelessWidget {
  const Tabs({
    Key? key,
    required this.press,
    required this.isDartkTheme,
  }) : super(key: key);
  // var
  final ValueChanged<int> press;
  final bool isDartkTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 250),
      width: SizeConfig.screenWidth * 0.3, // 80%
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(12)),
      child: DefaultTabController(
        initialIndex: isDartkTheme ? 1 : 0,
        length: 2,
        child: TabBar(
          indicator: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          indicatorColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          //  dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: press,
          tabs: [
            Row(children: [
              const Expanded(child: Tab(text: "")),
              Icon(Icons.wb_sunny,
                  color: isDartkTheme ? Colors.white30 : Colors.orange)
            ]),
            Row(children: [
              const Expanded(child: Tab(text: "")),
              Icon(Icons.brightness_2,
                  color: isDartkTheme ? Colors.yellow : Colors.white30)
            ]),
          ],
        ),
      ),
    );
  }
}

class ImgSol extends StatefulWidget {
  const ImgSol({
    Key? key,
    required Duration duration,
    required this.isFullSun,
  })  : _duration = duration,
        super(key: key);

  // var
  final Duration _duration;
  final bool isFullSun;

  @override
  _ImgSolState createState() => _ImgSolState();
}

class _ImgSolState extends State<ImgSol> with TickerProviderStateMixin {
  // var
  late AnimationController _controllerLogo;

  @override
  void initState() {
    super.initState();
    _controllerLogo = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controllerLogo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget._duration,
      curve: Curves.easeInOut,
      left: getProportionateScreenWidth(-30),
      bottom: getProportionateScreenWidth(!widget.isFullSun ? 650 : -200),
      child: Lottie.asset(
        'assets/AnimatioSol.json',
        controller: _controllerLogo,
        height: 200,
        width: 300.0,
        onLoaded: (composition) {
          setState(() {
            _controllerLogo.duration = composition.duration;
            _controllerLogo.repeat();
          });
        },
      ),
    );
  }
}

class ImgLuna extends StatefulWidget {
  const ImgLuna({
    Key? key,
    required Duration duration,
    required this.isFullSun,
  })  : _duration = duration,
        super(key: key);

  // var
  final Duration _duration;
  final bool isFullSun;

  @override
  _ImgLunaState createState() => _ImgLunaState();
}

class _ImgLunaState extends State<ImgLuna> with TickerProviderStateMixin {
  // var
  late AnimationController _controllerLogo = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    _controllerLogo = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controllerLogo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget._duration,
      curve: Curves.easeInOut,
      left: getProportionateScreenWidth(-70),
      bottom: getProportionateScreenWidth(widget.isFullSun ? 650 : -200),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 100.0, top: 150.0),
          child: AnimatedOpacity(
            opacity: widget.isFullSun ? 1 : 0.0,
            duration: widget._duration,
            curve: Curves.easeOut,
            child: Lottie.asset(
              'assets/AnimatioLuna.json',
              controller: _controllerLogo,
              height: 200,
              width: 200.0,
              onLoaded: (composition) {
                setState(() {
                  _controllerLogo.duration = composition.duration;
                  _controllerLogo.repeat();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ImgGalaxy extends StatelessWidget {
  const ImgGalaxy({
    Key? key,
    required Duration duration,
    required this.isFullSun,
  })  : _duration = duration,
        super(key: key);

  // var
  final Duration _duration;
  final bool isFullSun;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isFullSun ? 1 : 0.4,
      duration: _duration,
      curve: Curves.easeOut,
      child: Image.asset(
        "assets/galaxy.jpg",
        gaplessPlayback: true,
        //height: getProportionateScreenWidth(430),
        fit: BoxFit.fill,
      ),
    );
  }
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

/// FUNCTIONS
// Obtenga la altura proporcional según el tamaño de la pantalla
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // Nuestra diseñadora usa iPhone 11, por eso usamos 896.0(femenino)
  return (inputHeight / 896.0) * screenHeight;
}

// Obtenga la altura proporcional según el tamaño de la pantalla
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 414 es el ancho de diseño que usa el diseñador o puede decir ancho del iPhone 11
  return (inputWidth / 414.0) * screenWidth;
}

// Para agregar espacio libre verticalmente
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    Key? key,
    this.of = 25,
  }) : super(key: key);

  // var
  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(of),
    );
  }
}

class ImgTierra extends StatelessWidget {
  const ImgTierra({Key? key, required this.isDarak}) : super(key: key);

  // var
  final bool isDarak;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: getProportionateScreenWidth(-120),
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(isDarak ? "assets/1.png" : "assets/1.png",
            fit: BoxFit.cover),
      ),
    );
  }
}
