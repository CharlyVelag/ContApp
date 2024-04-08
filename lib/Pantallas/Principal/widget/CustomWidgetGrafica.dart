// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_13/Pantallas/Login/login.dart';
import 'package:flutter_application_13/Pantallas/Principal/widget/customsheet.dart';
import 'package:flutter_application_13/Pantallas/categorias/provider/providerCategorias.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../categorias/services/operaciones.dart';

class PieChart extends StatelessWidget {
  final String idUser;
  final String imgUser;
  final String nombre;
  const PieChart(
      {Key? key,
      required this.idUser,
      required this.imgUser,
      required this.nombre})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCategoria>(context, listen: false);
    return SfCircularChart(
        title: ChartTitle(text: 'Gastos por categoria en el mes'),
        legend: Legend(isVisible: true),
        series: <PieSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
              onPointTap: (detalles) {
                print(detalles.pointIndex);
                int identificador = detalles.pointIndex!;
                provider.totalgastos(
                  globalIdUser,
                );
                identificador == 0
                    ? provider.obtenerCategoria("Comida", globalIdUser)
                    : identificador == 1
                        ? provider.obtenerCategoria("Ropa", globalIdUser)
                        : identificador == 2
                            ? provider.obtenerCategoria("Viajes", globalIdUser)
                            : identificador == 3
                                ? provider.obtenerCategoria(
                                    "Gastosdelhogar", globalIdUser)
                                : identificador == 4
                                    ? provider.obtenerCategoria(
                                        "Entretenimiento", globalIdUser)
                                    : provider.obtenerCategoria(
                                        "Otros", globalIdUser);
                showBarModalBottomSheet(
                    isDismissible: false,
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => CustomSheetScreen(
                          identificador: detalles.pointIndex!,
                          iduser: idUser,
                          imgUser: imgUser,
                          nombre: nombre,
                        ));
              },
              explode: true,
              explodeIndex: 0,
              dataSource: llenadodatos(context),
              xValueMapper: (_PieData data, _) => data.xData,
              yValueMapper: (_PieData data, _) => data.yData,
              dataLabelMapper: (_PieData data, _) => data.text,
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
        ]);
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}

final List<_PieData> pieData = [];

List<_PieData> llenadodatos(BuildContext context) {
  pieData.clear();
  final pc = Provider.of<ProviderCategoria>(context);
  if (pc.carga) {
    pieData.add(_PieData(
        "Comida",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(0, context)), 0)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(0, context)), 0)}%"));
    pieData.add(_PieData(
        "Ropa",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(1, context)), 1)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(1, context)), 1)}%"));
    pieData.add(_PieData(
        "Viajes",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(2, context)), 2)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(2, context)), 2)}%"));
    pieData.add(_PieData(
        "Compras del hogar",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(3, context)), 3)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(3, context)), 3)}%"));
    pieData.add(_PieData(
        "Entretenimiento",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(4, context)), 4)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(4, context)), 4)}%"));
    pieData.add(_PieData(
        "Otros",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(5, context)), 5)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(5, context)), 5)}%"));
    return pieData;
  } else {
    pieData.add(_PieData(
        "Comida",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(0, context)), 0)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(0, context)), 0)}%"));
    pieData.add(_PieData(
        "Ropa",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(1, context)), 1)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(1, context)), 1)}%"));
    pieData.add(_PieData(
        "Viajes",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(2, context)), 2)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(2, context)), 2)}%"));
    pieData.add(_PieData(
        "Compras del hogar",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(3, context)), 3)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(3, context)), 3)}%"));
    pieData.add(_PieData(
        "Entretenimiento",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(4, context)), 4)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(4, context)), 4)}%"));
    pieData.add(_PieData(
        "Otros",
        double.parse(Operaciones().porcentaje(
            context, double.parse(Operaciones().calcularMes(5, context)), 5)),
        "${Operaciones().porcentaje(context, double.parse(Operaciones().calcularMes(5, context)), 5)}%"));
    return pieData;
  }
}
