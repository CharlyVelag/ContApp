import 'package:flutter/material.dart';

class Providerprincipal with ChangeNotifier {
  bool _salir = false;
  bool _info = false;
  bool get salir => _salir;
  set salir(bool value) {
    _salir = value;
    notifyListeners();
  }

  bool get info => _info;
  set info(bool value) {
    _info = value;
    notifyListeners();
  }
}
