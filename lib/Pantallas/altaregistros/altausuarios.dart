// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/provider/providerregistros.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/widget/customAppbar.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/widget/customFormulario.dart';
import 'package:flutter_application_13/Pantallas/categorias/services/operaciones.dart';
import 'package:flutter_application_13/widgetsApp/islandDinamic.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../widgetsApp/islanaux.dart';
import '../categorias/provider/providerCategorias.dart';

TextEditingController descrip = TextEditingController(text: "");
TextEditingController fecha = TextEditingController(text: "");
TextEditingController cantidad = TextEditingController(text: "");

class PantallaAltaRegistro extends StatefulWidget {
  final String categoria;
  final String iduser;
  final String img;
  const PantallaAltaRegistro({
    Key? key,
    required this.categoria,
    required this.img,
    required this.iduser,
  }) : super(key: key);

  @override
  State<PantallaAltaRegistro> createState() => _PantallaAltaRegistroState();
}

class _PantallaAltaRegistroState extends State<PantallaAltaRegistro> {
  String? base64String;
  bool useRetroseso = true;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderAltasRegistro>(context);
    final pc = Provider.of<ProviderCategoria>(context);

    return WillPopScope(
      onWillPop: () async {
        provider.image = File("NoPath");
        pc.totalgastos(widget.iduser);
        pc.totalgastosMes(widget.iduser);
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CustomAppBar(nombre: widget.categoria, img: widget.img),
                      SizedBox(
                        height: _size.height - 200,
                        child: AnimationLimiter(
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                                top: _size.height * 0.02,
                                right: 10,
                                left: 10,
                                bottom: 20),
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FadeInAnimation(
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration:
                                          const Duration(milliseconds: 2500),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomFormulario(
                                                numero: index + 1),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                loadingappCustomCharly(provider, context),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  showImageSource(context);
                },
                tooltip: "Scanner con IA",
                iconSize: 25,
                padding: EdgeInsets.zero,
                icon: Lottie.asset(
                  'assets/AnimationScanner.json',
                  height: 300,
                  width: 300.0,
                  animate: true,
                  repeat: true,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                  width: 110,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      colors: <Color>[
                        Color(0xff0097B2),
                        Color(0xff0E6EC9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      insertRegistro(context);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Guardar ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            MdiIcons.contentSaveAllOutline,
                            color: Colors.white,
                          )
                        ]),
                  )),
            ],
          )),
    );
  }

  insertRegistro(BuildContext context) async {
    final provider = Provider.of<ProviderAltasRegistro>(context, listen: false);
    final providerCat = Provider.of<ProviderCategoria>(context, listen: false);

    print(descrip.text);
    print(cantidad.text);
    print(provider.image.path);
    if (descrip.text.isNotEmpty &&
        provider.image.path != "NoPath" &&
        cantidad.text.isNotEmpty) {
      List<int> imagenBytes = await File(provider.image.path).readAsBytes();
      base64String = base64.encode(imagenBytes);
      debugPrint(base64String);

      var newCat = widget.categoria.replaceAll("Compras", "Gastos");

      print("descrip: " + descrip.text + " - cantindad: " + cantidad.text);
      var response = await provider.insertNuevoRegistro(
          "registro${newCat.replaceAll(" ", "")}",
          widget.iduser,
          descrip.text,
          cantidad.text,
          fecha.text,
          base64String!,
          0);

      print(response);
      if (response) {
        providerCat.obtenerDatosCarruselMes(newCat.replaceAll(" ", ""),
            widget.iduser, providerCat.mesSelect, providerCat.yearProvider);
        provider.image = File("NoPath");

        providerCat.totalgastos(widget.iduser);
        providerCat.totalgastosMes(widget.iduser);
        Operaciones().totalesMes(context);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(MdiIcons.informationBoxOutline),
                Text(
                  "Ocurrio un error al insertar nuevo registro intente de nuevo",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(MdiIcons.informationBoxOutline),
              Text(
                "Advertencia: Datos imcompletos",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )));
    }
  }

  SizedBox loadingappCustomCharly(
      ProviderAltasRegistro p, BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CrearLoader(
        heigth: 200,
        topHeigthPosicion: size.height / 3,
        mostrarLoader: p.cargaInsertar,
        color: Colors.black,
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Cargando",
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

//!Metodos para vizualizacion y uso de camra
  Future<ImageSource?> showImageSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.greenAccent,
          ),
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
        builder: (context) => FractionallySizedBox(
              heightFactor: 0.2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text("Galeria"),
                          contentPadding: const EdgeInsets.all(5),
                          onTap: () {
                            Navigator.of(context).pop();
                            getImage(ImageSource.gallery, context);
                          }),
                    ),
                    const Flexible(flex: 1, child: SizedBox()),
                    Flexible(
                      flex: 2,
                      child: ListTile(
                          leading: const Icon(Icons.camera_alt),
                          contentPadding: const EdgeInsets.all(5),
                          title: const Text("Camara"),
                          onTap: () {
                            Navigator.of(context).pop();
                            getImage(ImageSource.camera, context);
                          }),
                    )
                  ],
                ),
              ),
            ));
  }

  Future<void> getImage(ImageSource imageSource, BuildContext context) async {
    final provider = Provider.of<ProviderAltasRegistro>(context, listen: false);

    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;

      List<CropAspectRatioPreset> aspectRatioPresets = const [
        CropAspectRatioPreset.original,
        //CropAspectRatioPreset.square,
        //CropAspectRatioPreset.ratio3x2,
        //CropAspectRatioPreset.ratio4x3,
        //CropAspectRatioPreset.ratio16x9
      ];
      final cropped = (await ImageCropper().cropImage(
        cropStyle: CropStyle.rectangle,
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 600, ratioY: 400),
        compressQuality: 50,
        aspectRatioPresets: aspectRatioPresets,
        maxWidth: 700,
        maxHeight: 450,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Recorta tu imagen',
              toolbarColor: HexColor("#0097B2"),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Recorta tu imagen',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      ));
      final imageTemp = File(cropped!.path);
      provider.image = imageTemp;
      reconocimientoText(image, context);
      //debugPrint(imageTemp.toString());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        debugPrint("Error al escoger la imagen $e");
      }
    }
  }

  Future<void> reconocimientoText(XFile image, BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      Navigator.of(context).pop();
    });
    String fechaPattern =
        r"^(?:3[01]|[12][0-9]|0?[1-9])([\-/.])(0?[1-9]|1[1-2])\1\d{2}$"; //! para 02/02/23
    String fecha2Pattern =
        r"^(?:3[01]|[12][0-9]|0?[1-9])([\-/.])(0?[1-9]|1[1-2])\1\d{4}$"; //! para 02/02/2023

    RegExp cregex = RegExp(r'^[0-9]+([.][0-9]{1,2})');
    RegExp cregex2 = RegExp(r'^[0-9]+([,][0-9]{1,3})+([.][0-9]{1,2})$');
    RegExp letrasregex = RegExp(r'^[0-9]+([.][0-9]{1,2})+([a-zA-Z])$');
    RegExp numregex = RegExp(r'^[0-9]');

    RegExp regEx = RegExp(fechaPattern);
    RegExp regEx2 = RegExp(fecha2Pattern);

    List<double> keynum = [];
    //todo COmienzo de reconocimiento
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    descrip.text = recognizedText.blocks.first.lines.first.text;

    for (TextBlock block in recognizedText.blocks) {
      //debugPrint(block.text);
      for (TextLine lines in block.lines) {
        if (kDebugMode) {
          print(lines.elements[0].text);
        }
        if (regEx.hasMatch(lines.elements[0].text) ||
            regEx2.hasMatch(lines.elements[0].text)) {
          voidFormatoFechaCamara(lines.elements[0].text);
        }
        if (cregex.hasMatch(lines.elements[0].text) ||
            cregex2.hasMatch(lines.elements[0].text)) {
          // debugPrint("NUmero dobles ${lines.elements[0].text}");
          String numF = "";
          if (lines.elements[0].text.contains("%") ||
              letrasregex.hasMatch(lines.elements[0].text)) {
          } else {
            if (lines.elements[0].text.contains(',')) {
              numF = lines.elements[0].text.replaceAll(',', "");
              double d = double.parse(numF);
              keynum.add(d);
            } else {
              numF = lines.elements[0].text;
              double d = double.parse(numF);
              keynum.add(d);
            }
          }
        }
        if (lines.text == 21) {
          if (numregex.hasMatch(lines.text)) {
            //("CODIGOOOOOOOOO ${lines.text}");
          }
        }
      }
    }
    ordencantidades(keynum);
  }

  ordencantidades(List<double> keyd) {
    keyd.sort();
    cantidad.text = keyd[keyd.length - 1].toString();

    for (int i = 0; i < keyd.length; i++) {
      //debugPrint("Ordenado ${keyd[i]}");
      cantidad.text = keyd[keyd.length - 2].toString();
    }
  }

  voidFormatoFechaCamara(String fechaObt) {
    List<String> fSplit = fechaObt.split('/');
    DateTime now = DateTime.now();
    String year = "";
    if (fechaObt.length == 8) {
      //debugPrint("Ticket de Bodega: fecha $fecha");
      String yearAux = now.year.toString();
      for (int i = 0; i < 2; i++) {
        year = year + yearAux[i];
      }
      year = year + fSplit[2];
      String fFormat = "$year/${fSplit[1]}/${fSplit[0]}";
      fecha.text = fFormat;
      // debugPrint("FechaFormateada: $fFormat");
    } else {
      //  debugPrint("Ticket de chedrahui: fecha $fecha");
      String fFormat = "${fSplit[2]}/${fSplit[1]}/${fSplit[0]}";
      fecha.text = fFormat;
    }
  }
}
