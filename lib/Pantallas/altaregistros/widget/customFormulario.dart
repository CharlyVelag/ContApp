// ignore_for_file: file_names, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/altausuarios.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/provider/providerregistros.dart';
import 'package:flutter_application_13/Pantallas/altaregistros/widget/customInputs.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:provider/provider.dart';

class CustomFormulario extends StatefulWidget {
  final int numero;
  const CustomFormulario({Key? key, required this.numero}) : super(key: key);

  @override
  State<CustomFormulario> createState() => _CustomFormularioState();
}

class _CustomFormularioState extends State<CustomFormulario> {
  SpeechToText _speechToText = SpeechToText();
  // ignore: unused_field
  bool _speechEnabled = false;
  bool isListen = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    print("Iniciamos listening");
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }
  void _stopListening() async {
    print("Apagamos listening");
    await _speechToText.stop();
    setState(() {});
  }
  void _onSpeechResult(SpeechRecognitionResult result) {
    print(result);
    setState(() {
      _lastWords = result.recognizedWords;
      print(_lastWords);
      if (_speechToText.isNotListening) {
        isListen = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderAltasRegistro>(context);
    var datetime = DateTime.now();
    var month = "";

    if (datetime.month < 10) {
      month = "0${datetime.month}";
    } else {
      month = datetime.month.toString();
    }
    if (_lastWords.isNotEmpty) {
      fecha.text = "${datetime.year}-$month-${datetime.day}";
      descrip.text = _lastWords;
      cantidad.text = "";
    }
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 2,
            offset: const Offset(1, 3))
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: size.width - 20,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ValidationTextField(
                  icon: MdiIcons.note,
                  hinttext: "Descripción",
                  id: 1,
                  textEditingController: descrip,
                ),
              ),
              isListen
                  ? IconButton(
                      onPressed: () {
                        print(_lastWords);
                        setState(() {
                          isListen = false;
                        });
                        _stopListening();
                      },
                      icon: Lottie.asset(
                        'assets/AnimationMicorofone.json',
                        height: 200,
                        width: 200.0,
                      ),
                    )
                  : IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          isListen = true;
                        });
                        _startListening();
                      },
                      icon: Icon(
                        MdiIcons.microphone,
                        color: Colors.blue[700],
                      ))
            ],
          ),
          // ValidationTextField(),
          Row(
            children: [
              Expanded(
                  child: ValidationTextField(
                icon: MdiIcons.calendarAccount,
                hinttext: "Fecha",
                id: 2,
                textEditingController: fecha,
              )),
              Expanded(
                  child: ValidationTextField(
                icon: MdiIcons.cash100,
                hinttext: "\$0.00",
                id: 3,
                textEditingController: cantidad,
              ))
            ],
          ),
          Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: const BoxDecoration(
                    color: Color(0xff0E6EC9),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: provider.image.path.contains("NoPath")
                        ? null
                        : Image.file(
                            provider.image,
                            fit: BoxFit.fill,
                          )),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xff0E6EC9),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Agregar comprobante",
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          getImage(1, provider);
                        },
                        icon: const Icon(
                          MdiIcons.cameraOutline,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          getImage(2, provider);
                        },
                        icon: const Icon(
                          MdiIcons.cameraBurst,
                          color: Colors.white,
                        ))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  final picker = ImagePicker();

  Future getImage(int option, ProviderAltasRegistro provider) async {
    XFile? pickedfile;
    if (option == 1) {
      pickedfile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedfile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedfile != null) {
      List<CropAspectRatioPreset> aspectRatioPresets = const [
        CropAspectRatioPreset.original,
      ];
      final cropped = (await ImageCropper().cropImage(
        cropStyle: CropStyle.rectangle,
        sourcePath: pickedfile.path,
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
      provider.image = File(cropped!.path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(MdiIcons.informationBoxOutline),
              Text(
                "No selecciono ningun archivo",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )));
    }
  }
}
