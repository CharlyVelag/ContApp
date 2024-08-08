// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_13/Pantallas/categorias/model/Modeloviajes.dart';
import 'package:flutter_application_13/Pantallas/categorias/provider/providerCategorias.dart';
import 'package:provider/provider.dart';

class Operaciones {
  String calcularTotales(List<ModeloCategoria> model) {
    double sum = 0;
    for (int i = 0; i < model.length; i++) {
      var c = double.parse(model[i].cantidad);
      sum = sum + c;
    }
    String sumAux = sum.toString();

    if (sumAux.contains(".")) {
      var cants = sumAux.split(".");
      var parteInt = cants[0];
      var parteDec = cants[1];
      if (cants[1].length < 2) {
        if (parteDec.isEmpty || parteDec == "") {
          parteDec = "00";
        } else {
          parteDec = cants[1] + "0";
        }
      }
      return parteInt + "." + parteDec;
    } else {
      return sumAux + ".00";
    }
  }

  String porcentaje(BuildContext context, double keyAux, int id) {
    final p = Provider.of<ProviderCategoria>(context);

    double keySum1 = 0;
    double keySum2 = 0;
    double keySum3 = 0;
    double keySum4 = 0;
    double keySum5 = 0;
    double keySum6 = 0;

    for (int i = 0; i < p.modelo1aux.length; i++) {
      double aux = double.parse(p.modelo1aux[i].cantidad);
      keySum1 = keySum1 + aux;
    }

    for (int i = 0; i < p.modelo2aux.length; i++) {
      double aux = double.parse(p.modelo2aux[i].cantidad);
      keySum2 = keySum2 + aux;
    }

    for (int i = 0; i < p.modelo3aux.length; i++) {
      double aux = double.parse(p.modelo3aux[i].cantidad);
      keySum3 = keySum3 + aux;
    }

    for (int i = 0; i < p.modelo4aux.length; i++) {
      double aux = double.parse(p.modelo4aux[i].cantidad);
      keySum4 = keySum4 + aux;
    }

    for (int i = 0; i < p.modelo5aux.length; i++) {
      double aux = double.parse(p.modelo5aux[i].cantidad);
      keySum5 = keySum5 + aux;
    }

    for (int i = 0; i < p.modelo6aux.length; i++) {
      double aux = double.parse(p.modelo6aux[i].cantidad);
      keySum6 = keySum6 + aux;
    }

    double t = keySum1 + keySum2 + keySum3 + keySum4 + keySum5 + keySum6;
    double porcent =
        (keyAux * 100) / double.parse(Operaciones().totalesMes(context));
    /*  print("$keyAux * 100 / ${Operaciones().totalesMes(context)} - $id");
    print(":::: $t :::: $porcent");*/
    /*p.porcentaje = (porcent <= 0 ||
            porcent.toString() == "NaN" ||
            porcent.toString() == "Infinity")
        ? "0.0"
        : porcent.toStringAsFixed(2);*/
    return (porcent <= 0 ||
            porcent.toString() == "NaN" ||
            porcent.toString() == "Infinity")
        ? "0.0"
        : porcent.toStringAsFixed(2);
  }

  String totales(BuildContext context) {
    final p = Provider.of<ProviderCategoria>(context);

    double keySum1 = 0;
    double keySum2 = 0;
    double keySum3 = 0;
    double keySum4 = 0;
    double keySum5 = 0;
    double keySum6 = 0;

    for (int i = 0; i < p.modelo1.length; i++) {
      double aux = double.parse(p.modelo1[i].cantidad);
      keySum1 = keySum1 + aux;
    }

    for (int i = 0; i < p.modelo2.length; i++) {
      double aux = double.parse(p.modelo2[i].cantidad);
      keySum2 = keySum2 + aux;
    }

    for (int i = 0; i < p.modelo3.length; i++) {
      double aux = double.parse(p.modelo3[i].cantidad);
      keySum3 = keySum3 + aux;
    }

    for (int i = 0; i < p.modelo4.length; i++) {
      double aux = double.parse(p.modelo4[i].cantidad);
      keySum4 = keySum4 + aux;
    }

    for (int i = 0; i < p.modelo5.length; i++) {
      double aux = double.parse(p.modelo5[i].cantidad);
      keySum5 = keySum5 + aux;
    }

    for (int i = 0; i < p.modelo6.length; i++) {
      double aux = double.parse(p.modelo6[i].cantidad);
      keySum6 = keySum6 + aux;
    }

    double t = keySum1 + keySum2 + keySum3 + keySum4 + keySum5 + keySum6;

    return t <= 0 ? "0.0" : t.toStringAsFixed(2);
  }

  String totalesMes(BuildContext context) {
    final p = Provider.of<ProviderCategoria>(context);

    double keySum1 = 0;
    double keySum2 = 0;
    double keySum3 = 0;
    double keySum4 = 0;
    double keySum5 = 0;
    double keySum6 = 0;

    for (int i = 0; i < p.modelo1aux.length; i++) {
      double aux = double.parse(p.modelo1aux[i].cantidad);
      keySum1 = keySum1 + aux;
    }

    for (int i = 0; i < p.modelo2aux.length; i++) {
      double aux = double.parse(p.modelo2aux[i].cantidad);
      keySum2 = keySum2 + aux;
    }

    for (int i = 0; i < p.modelo3aux.length; i++) {
      double aux = double.parse(p.modelo3aux[i].cantidad);
      keySum3 = keySum3 + aux;
    }

    for (int i = 0; i < p.modelo4aux.length; i++) {
      double aux = double.parse(p.modelo4aux[i].cantidad);
      keySum4 = keySum4 + aux;
    }

    for (int i = 0; i < p.modelo5aux.length; i++) {
      double aux = double.parse(p.modelo5aux[i].cantidad);
      keySum5 = keySum5 + aux;
    }

    for (int i = 0; i < p.modelo6aux.length; i++) {
      double aux = double.parse(p.modelo6aux[i].cantidad);
      keySum6 = keySum6 + aux;
    }

    double t = keySum1 + keySum2 + keySum3 + keySum4 + keySum5 + keySum6;
   // p.totalMes = t <= 0 ? "0.0" : t.toStringAsFixed(2);
    return t <= 0 ? "0.0" : t.toStringAsFixed(2);
  }

  String totMesesCategoria(List<ModeloCategoria> model) {
    double sum = 0;
    for (var i = 0; i < model.length; i++) {
      sum = sum + double.parse(model[i].cantidad);
    }
    return sum.toStringAsFixed(2);
  }

//Todo: Calcular los gastos del mes actual
  String calcularMes(int id, BuildContext context) {
    final p = Provider.of<ProviderCategoria>(context);

    double sum = 0;
    List<ModeloCategoria>? model;
    if (id == 0) {
      model = p.modelo2aux;
    }
    if (id == 1) {
      model = p.modelo3aux;
    }
    if (id == 2) {
      model = p.modelo1aux;
    }
    if (id == 3) {
      model = p.modelo5aux;
    }
    if (id == 4) {
      model = p.modelo4aux;
    }
    if (id == 5) {
      model = p.modelo6aux;
    }

    for (int i = 0; i < model!.length; i++) {
      var c = double.parse(model[i].cantidad);
      sum = sum + c;
    }
    String sumAux = sum.toString();

    if (sumAux.contains(".")) {
      var cants = sumAux.split(".");
      var parteInt = cants[0];
      var parteDec = cants[1];
      if (cants[1].length < 2) {
        if (parteDec.isEmpty || parteDec == "") {
          parteDec = "00";
        } else {
          parteDec = cants[1] + "0";
        }
      }
    //  p.calcularMes = parteInt + "." + parteDec;
      return parteInt + "." + parteDec;
    } else {
   //   p.calcularMes = sumAux + ".00";
      return sumAux + ".00";
    }
  }
}
