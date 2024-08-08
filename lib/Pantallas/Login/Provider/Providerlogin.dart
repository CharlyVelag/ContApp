// ignore_for_file: file_names, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Login/Model/modellogin.dart';
import 'package:flutter_application_13/configuracionesGlobales.dart';

import '../../../ApiFlutterConnectMySQL/apiflutterconnectmysql.dart';


class ProviderLogin with ChangeNotifier {
  String nombre = "";
  String foto = "";
  bool _carga = false;
  bool _error = false;
  bool _alert = false;
  Map userObj = {};
  bool _insert = false;
  List<ModeloLoginUser> modelUser = [];

  bool get carga => _carga;
  set carga(bool value) {
    _carga = value;
    notifyListeners();
  }

  bool get verAlert => _alert;
  set verAlert(bool value) {
    _alert = value;
    notifyListeners();
  }

  bool get insert => _insert;
  set insert(bool value) {
    _insert = value;
    notifyListeners();
  }

  bool get error => _error;
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

//INsertar
  insertNuevousuario(
    String nombre,
    String mailorfacebookid,
    String email,
    String pass,
    String telefono,
    String tipoRegistro,
  ) async {
    carga = true;
    notifyListeners();
    try {
      String urlString =
          '${ConfiguracionesGlobales().urlHost}/Services/getDatos/insertUsers.php';

      var formData = FormData.fromMap({
        'nombre': nombre,
        'pass': pass,
        'email': email.replaceAll(" ", ""),
        'mailorfacebookid': mailorfacebookid,
        'telefono': telefono,
        'tipoRegistro': tipoRegistro
      });

      final response = await Dio()
          .post(
        urlString,
        data: formData,
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () async {
          carga = false;
          error = true;

          notifyListeners();

          return Future.value(Dio().post(""));
        },
      );

      print("DATOS: " + response.data + " - " + response.statusCode.toString());

      if (response.statusCode != 200) {
        carga = false;
        print("Error");
        error = true;

        notifyListeners();
      } else {
        //Aqui éticion exitosa
        print(response.data);
        carga = false;
        if (response.data == "InsertSucces") {
          insert = true;
          error = false;
          notifyListeners();
        } else {
          insert = false;
          error = true;
          notifyListeners();
        }
        notifyListeners();
      }
    } on DioException catch (e) {
      carga = false;
      error = true;

      print(e);
      notifyListeners();
    }
  }

//!Obtener usuario
  Future<bool> obtenerUser(
      String mailorfacebookid, String pass, String action) async {
    carga = true;
    modelUser.clear();
    notifyListeners();
    try {
      String urlString =
          '${ConfiguracionesGlobales().urlHost}/Services/getDatos/getUser.php';

      var formData = FormData.fromMap({
        'mailorfacebookid': mailorfacebookid,
        'pass': pass,
        'action': action
      });

      final response = await Dio()
          .post(
        urlString,
        data: formData,
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () async {
          carga = false;
          error = true;
          notifyListeners();
          return Future.value(Dio().post(""));
        },
      );

      print("DATOS: " + response.data + " - " + response.statusCode.toString());

      if (response.statusCode != 200) {
        carga = false;
        print("Error");
        error = true;

        notifyListeners();
        return false;
      } else {
        //Aqui éticion exitosa
        print(response.data);
        carga = false;
        error = false;
        final jsonDats = modeloUserFromJson(response.data);
        modelUser.addAll(jsonDats);
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      carga = false;
      error = true;

      print(e);
      notifyListeners();
      return false;
    }
  }

  Future<String> verificarCorreo(String correo) async {
    carga = true;
    notifyListeners();
    try {
      String urlString = ApiFlutterConnectMysql.login;
      print(urlString);
     var formData = FormData.fromMap({
        'actioncrud': "VerificarCorreo",
        'email': correo.replaceAll(" ", ""),
      });

      final response = await Dio()
          .post(
        urlString,
        data: formData,
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () async {
          carga = false;
          error = true;
          notifyListeners();
          return Future.value(Dio().post(""));
        },
      );

      print("DATOS: " + response.data + " - " + response.statusCode.toString());

      if (response.statusCode != 200) {
        carga = false;
        print("Error");
        error = true;

        notifyListeners();
        return "Error";
      } else {
        //Aqui éticion exitosa
        print(response.data);
        carga = false;
        error = false;

        notifyListeners();
        if (response.data == "Si_Existe_Correo") {
          return "Si";
        } else {
          return "No";
        }
      }
    } on DioException catch (e) {
      carga = false;
      error = true;

      print(e);
      notifyListeners();
      return "Error";
    }
  }
}
