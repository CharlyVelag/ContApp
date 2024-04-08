// ignore_for_file: file_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/categorias/model/Modeloviajes.dart';
import 'package:dio/dio.dart';

class ProviderCategoria with ChangeNotifier {
  bool _carga = false;
  bool _valorCheck = false;
  int _yearProvider = 0;
  bool _error = false;
  int _mesSelected = 0;
  Map userObj = {};
  String _totalMes = "0.00";
  String _calcularMes = "0.00";
  String _porcentaje = "0.00";
  bool _cargaAux = false;

  List<ModeloCategoria> modeloViajes = [];

  List<ModeloCategoria> modelo1 = [];
  List<ModeloCategoria> modelo2 = [];
  List<ModeloCategoria> modelo3 = [];
  List<ModeloCategoria> modelo4 = [];
  List<ModeloCategoria> modelo5 = [];
  List<ModeloCategoria> modelo6 = [];

  List<ModeloCategoria> modelo1aux = [];
  List<ModeloCategoria> modelo2aux = [];
  List<ModeloCategoria> modelo3aux = [];
  List<ModeloCategoria> modelo4aux = [];
  List<ModeloCategoria> modelo5aux = [];
  List<ModeloCategoria> modelo6aux = [];

  List<ModeloCategoria> modelSelecmes = [];

  bool get carga => _carga;
  set carga(bool value) {
    _carga = value;
    notifyListeners();
  }

  bool get cargaAux => _cargaAux;
  set cargaAux(bool value) {
    _cargaAux = value;
    notifyListeners();
  }

  bool get valorCheck => _valorCheck;
  set valorCheck(bool value) {
    _valorCheck = value;
    notifyListeners();
  }

  bool get error => _error;
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  int get mesSelect => _mesSelected;
  set mesSelect(int value) {
    _mesSelected = value;
    notifyListeners();
  }

  int get yearProvider => _yearProvider;
  set yearProvider(int value) {
    _yearProvider = value;
    notifyListeners();
  }

  /*String get totalMes => _totalMes;
  set totalMes(String value) {
    _totalMes = value;
    notifyListeners();
  }

  String get calcularMes => _calcularMes;
  set calcularMes(String value) {
    _calcularMes = value;
    notifyListeners();
  }

  String get porcentaje => _porcentaje;
  set porcentaje(String value) {
    _porcentaje = value;
    notifyListeners();
  }*/

  Future<String> obtenerCategoria(String categoria, String id) async {
    carga = true;
    modeloViajes.clear();
    notifyListeners();
    print(categoria);
    try {
      String urlString =
          'https://controlappv2.000webhostapp.com/Services/getDatos/GetDataAppv2.php';
      var action = "totalMes";
      var mes;
      var year;
      var dt = DateTime.now();
      mes = dt.month;
      year = dt.year;

      if (dt.year < 10) {
        year = "0" + year.toString();
      }
      if (dt.month < 10) {
        mes = "0" + mes.toString();
      }
      var formData = FormData.fromMap({
        'categoria': categoria,
        'action': action,
        'mes': mes,
        'year': year,
        "id": id
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
        final jsonDats = modeloCategoriaFromJson(response.data);
        modeloViajes.addAll(jsonDats);
        carga = false;
        error = false;
        notifyListeners();
      }
    } on DioException catch (e) {
      carga = false;
      error = true;

      print(e);
      notifyListeners();
    }
    double sum = 0;
    for (int i = 0; i < modeloViajes.length; i++) {
      sum = sum + double.parse(modeloViajes[i].cantidad);
    }
    return sum.toStringAsFixed(2);
  }

  totalgastos(String id) async {
    carga = true;
    cargaAux = true;
    modelo1.clear();
    modelo2.clear();
    modelo3.clear();
    modelo4.clear();
    modelo5.clear();
    modelo6.clear();

    notifyListeners();
    try {
      String urlString =
          'https://controlappv2.000webhostapp.com/Services/getDatos/GetDataAppv2.php';
      var action = "total";
      for (int i = 0; i < 6; i++) {
        if (i == 0) {
          var formData = FormData.fromMap(
              {'categoria': "Viajes", 'action': action, "id": id});

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
          if (response.statusCode != 200) {
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo1.addAll(jsonDats);
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 1) {
          var formData = FormData.fromMap(
              {'categoria': "Comida", 'action': action, "id": id});

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
          if (response.statusCode != 200) {
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo2.addAll(jsonDats);
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 2) {
          var formData = FormData.fromMap(
              {'categoria': "Ropa", 'action': action, "id": id});

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
          if (response.statusCode != 200) {
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo3.addAll(jsonDats);
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 3) {
          var formData = FormData.fromMap(
              {'categoria': "Entretenimiento", 'action': action, "id": id});

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
          if (response.statusCode != 200) {
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo4.addAll(jsonDats);
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 4) {
          var formData = FormData.fromMap(
              {'categoria': "Gastosdelhogar", 'action': action, "id": id});

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
          if (response.statusCode != 200) {
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo5.addAll(jsonDats);
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 5) {
          var formData = FormData.fromMap(
              {'categoria': "Otros", 'action': action, "id": id});

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
          if (response.statusCode != 200) {
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo6.addAll(jsonDats);
            carga = false;
            error = false;
            notifyListeners();
          }
        }
      }
    } on DioException catch (e) {
      carga = false;
      error = true;

      print(e);
      notifyListeners();
    }
  }

  //SELECT * FROM registroViajes WHERE MONTH(registroViajes.FechaPago) = 10 AND YEAR(registroViajes.FechaPago) = 2023;
  totalgastosMes(String id) async {
    cargaAux = true;
    carga = true;
    modelo1aux.clear();
    modelo2aux.clear();
    modelo3aux.clear();
    modelo4aux.clear();
    modelo5aux.clear();
    modelo6aux.clear();

    notifyListeners();
    try {
      String urlString =
          'https://controlappv2.000webhostapp.com/Services/getDatos/GetDataAppv2.php';
      var action = "totalMes";
      var mes;
      var year;
      var dt = DateTime.now();
      mes = dt.month;
      year = dt.year;

      if (dt.year < 10) {
        year = "0" + year.toString();
      }
      if (dt.month < 10) {
        mes = "0" + mes.toString();
      }
      print(action + " - " + mes.toString() + " - " + year.toString());

      for (int i = 0; i < 6; i++) {
        if (i == 0) {
          var formData = FormData.fromMap({
            'categoria': "Viajes",
            'action': action,
            'mes': mes,
            'year': year,
            "id": id
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
              cargaAux = false;
              error = true;
              notifyListeners();

              return Future.value(Dio().post(""));
            },
          );
          print(":::--" + response.data);
          if (response.statusCode != 200) {
            carga = false;
            cargaAux = false;

            print("Error");
            error = true;

            notifyListeners();
          } else {
            print(response.data);
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo1aux.addAll(jsonDats);
            carga = false;
            cargaAux = false;

            error = false;
            notifyListeners();
          }
        }
        if (i == 1) {
          var formData = FormData.fromMap({
            'categoria': "Comida",
            'action': action,
            'mes': mes,
            'year': year,
            "id": id
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
              cargaAux = false;

              error = true;
              notifyListeners();

              return Future.value(Dio().post(""));
            },
          );
          print(":::--" + response.data);

          if (response.statusCode != 200) {
            cargaAux = false;
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo2aux.addAll(jsonDats);
            cargaAux = false;
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 2) {
          var formData = FormData.fromMap({
            'categoria': "Ropa",
            'action': action,
            'mes': mes,
            'year': year,
            "id": id
          });

          final response = await Dio()
              .post(
            urlString,
            data: formData,
          )
              .timeout(
            const Duration(seconds: 10),
            onTimeout: () async {
              cargaAux = false;
              carga = false;
              error = true;
              notifyListeners();

              return Future.value(Dio().post(""));
            },
          );
          print(":::--" + response.data);

          if (response.statusCode != 200) {
            cargaAux = false;
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo3aux.addAll(jsonDats);
            cargaAux = false;
            carga = false;
            error = false;
            notifyListeners();
          }
        }

        if (i == 3) {
          var formData = FormData.fromMap({
            'categoria': "Entretenimiento",
            'action': action,
            'mes': mes,
            'year': year,
            "id": id
          });

          final response = await Dio()
              .post(
            urlString,
            data: formData,
          )
              .timeout(
            const Duration(seconds: 10),
            onTimeout: () async {
              cargaAux = false;
              carga = false;
              error = true;
              notifyListeners();

              return Future.value(Dio().post(""));
            },
          );
          print(":::--" + response.data);

          if (response.statusCode != 200) {
            cargaAux = false;
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo4aux.addAll(jsonDats);
            cargaAux = false;
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 4) {
          var formData = FormData.fromMap({
            'categoria': "Gastosdelhogar",
            'action': action,
            'mes': mes,
            'year': year,
            "id": id
          });

          final response = await Dio()
              .post(
            urlString,
            data: formData,
          )
              .timeout(
            const Duration(seconds: 10),
            onTimeout: () async {
              cargaAux = false;
              carga = false;
              error = true;
              notifyListeners();

              return Future.value(Dio().post(""));
            },
          );
          print(":::--" + response.data);

          if (response.statusCode != 200) {
            cargaAux = false;
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo5aux.addAll(jsonDats);
            cargaAux = false;
            carga = false;
            error = false;
            notifyListeners();
          }
        }
        if (i == 5) {
          var formData = FormData.fromMap({
            'categoria': "Otros",
            'action': action,
            'mes': mes,
            'year': year,
            "id": id
          });

          final response = await Dio()
              .post(
            urlString,
            data: formData,
          )
              .timeout(
            const Duration(seconds: 10),
            onTimeout: () async {
              cargaAux = false;
              carga = false;
              error = true;
              notifyListeners();

              return Future.value(Dio().post(""));
            },
          );
          print(":::--" + response.data);

          if (response.statusCode != 200) {
            cargaAux = false;
            carga = false;
            print("Error");
            error = true;

            notifyListeners();
          } else {
            final jsonDats = modeloCategoriaFromJson(response.data);
            modelo6aux.addAll(jsonDats);
            cargaAux = false;
            carga = false;
            error = false;
            notifyListeners();
          }
        }
      }
    } on DioException catch (e) {
      carga = false;
      cargaAux = false;
      error = true;

      print(e);
      notifyListeners();
    }
  }

  obtenerDatosCarruselMes(
      String categoria, String id, int mesParam, int yearParam) async {
    carga = true;
    modelSelecmes.clear();
    notifyListeners();

    try {
      String urlString =
          'https://controlappv2.000webhostapp.com/Services/getDatos/GetDataAppv2.php';

      var action = "totalMes";
      var mes;
      var year;
      var dt = DateTime.now();
      year = yearParam == 0 ? dt.year : yearParam;
      if (mesParam < 10) {
        mes = "0$mesParam";
      } else {
        mes = mesParam;
      }

      var formData = FormData.fromMap({
        'categoria': categoria,
        'action': action,
        'id': id,
        'mes': mes,
        'year': year
      });
      print("cat- " + categoria);
      print("cat- " + mesParam.toString());
      print("cat- " + id);

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
        final jsonDats = modeloCategoriaFromJson(response.data);
        modelSelecmes.addAll(jsonDats);
        carga = false;
        error = false;
        notifyListeners();
      }
    } on DioException catch (e) {
      carga = false;
      error = true;

      print(e);
      notifyListeners();
    }
  }
}
