// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../configuracionesGlobales.dart';

class ProviderAltasRegistro with ChangeNotifier {
  File? _image = File("NoPath");
  bool _isListen = false;
  String _base64image = "";
  bool _cargaInsertar = false;
  bool _carga = true;
  bool _error = false;
  
  File get image => _image!;
  set image(File value) {
    _image = value;
    notifyListeners();
  }

  bool get isListen => _isListen;
  set isListen(bool value) {
    _isListen = value;
    notifyListeners();
  }

  String get base64image => _base64image;
  set base64image(String value) {
    _base64image = value;
    notifyListeners();
  }

  bool get carga => _carga;
  set carga(bool value) {
    _carga = value;
    notifyListeners();
  }

  bool get cargaInsertar => _cargaInsertar;
  set cargaInsertar(bool value) {
    _cargaInsertar = value;
    notifyListeners();
  }

  bool get error => _error;
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

// INSERT INTO `registroComida` (`Id_registro`, `Id_User`, `Descripcion`, `Cantidad`, `FechaPago`, `image`, `Facturado`)
  pruebas(String categoria, String iduser, String descrip, String cantidad,
      String fecha, String image, int facturado) async {
    String urlString =
        '${ConfiguracionesGlobales().urlHost}/Services/getDatos/actionsCRUD.php';

    var action = "InsertReg";

    var formData = FormData.fromMap({
      'actioncrud': action,
      'categoria': categoria,
      'iduser': iduser,
      'descrip': descrip,
      'cantidad': cantidad,
      'fecha': fecha,
      'image': image,
      'facturado': facturado
    });

    print(urlString);
    print(categoria + " - " + formData.fields.toString());
  }

  Future<bool> insertNuevoRegistro(
      String categoria,
      String iduser,
      String descrip,
      String cantidad,
      String fecha,
      String image,
      int facturado) async {
    cargaInsertar = true;
    notifyListeners();

    try {
      String urlString =
          '${ConfiguracionesGlobales().urlHost}/Services/getDatos/actionsCRUD.php';

      var action = "InsertReg";

      var formData = FormData.fromMap({
        'actioncrud': action,
        'categoria': categoria,
        'iduser': iduser,
        'descrip': descrip,
        'cantidad': cantidad,
        'fecha': fecha,
        'image': image,
        'facturado': facturado
      });

      print(urlString);
      print(categoria + " - " + formData.fields.toString());
      final response = await Dio()
          .post(
        urlString,
        data: formData,
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () async {
          cargaInsertar = false;
          error = true;
          notifyListeners();

          return Future.value(Dio().post(""));
        },
      );

      print("DATOS: " + response.data + " - " + response.statusCode.toString());

      if (response.statusCode != 200) {
        cargaInsertar = false;
        print("Error");
        error = true;
        notifyListeners();
        return false;
      } else {
        cargaInsertar = false;
        error = false;
        notifyListeners();

        if (response.data == "InsertSucces") {
          return true;
        } else {
          return false;
        }
      }
    } on DioException catch (e) {
      carga = false;
      error = true;
      print("Error $e");
      print(e.response);
      print(e.message);
      print(e.requestOptions.uri);
      notifyListeners();
      return false;
    }
  }
}
