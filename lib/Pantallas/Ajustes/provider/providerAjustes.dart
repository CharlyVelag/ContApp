import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Ajustes/model/modeluser.dart';

class ProviderAjustes with ChangeNotifier {
  bool _editable = false;
  List<InfoUser> infoUsuario = [];
  bool _carga = false;
  bool _error = false;

  bool get carga => _carga;
  set carga(bool value) {
    _carga = value;
    notifyListeners();
  }

  bool get error => _error;
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  bool get editable => _editable;
  set editable(bool value) {
    _editable = value;
    notifyListeners();
  }

  obtUsuario(int idUsuario) async {
    carga = true;
    infoUsuario.clear();
    notifyListeners();
    try {
      String urlString =
          'https://controlappv2.000webhostapp.com/Services/getDatos/getInfoUser.php';

      var formData = FormData.fromMap({
        'id': idUsuario,
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
        infoUsuario.addAll(jsonDats);
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

  actualizarDatos(
      String id, String correo, String pass, String telefono) async {
    carga = true;
    infoUsuario.clear();
    notifyListeners();
    try {
      String urlString =
          'https://controlappv2.000webhostapp.com/Services/getDatos/actionsCRUD.php';

      var formData = FormData.fromMap({
        'actioncrud': "UpdateUser",
        'idUser': id,
        'email': correo.replaceAll(" ", ""),
        'pass': pass,
        'telefono': telefono,
        'infocompleta': telefono.contains("No") ? "0" : "1"
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
        int idu = int.parse(id);
        obtUsuario(idu);
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
      String urlString =
          'https://controlappv2.000webhostapp.com/Services/getDatos/actionsCRUD.php';

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
