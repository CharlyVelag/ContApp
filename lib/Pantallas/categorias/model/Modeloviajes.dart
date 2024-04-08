// ignore_for_file: file_names

import 'dart:convert';

List<ModeloCategoria> modeloViajesFromMap(String str) =>
    List<ModeloCategoria>.from(
        json.decode(str).map((x) => ModeloCategoria.fromMap(x)));

String modeloViajesToMap(List<ModeloCategoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<ModeloCategoria> modeloCategoriaFromJson(String str) =>
    List<ModeloCategoria>.from(
        json.decode(str).map((x) => ModeloCategoria.fromJson(x)));

class ModeloCategoria {
  String idRegistro;
  String idUser;
  String descripcion;
  String cantidad;
  String fechaPago;
  String image;
  String facturado;

  ModeloCategoria(
      {required this.idRegistro,
      required this.idUser,
      required this.descripcion,
      required this.cantidad,
      required this.fechaPago,
      required this.image,
      required this.facturado});

  factory ModeloCategoria.fromMap(Map<String, dynamic> json) => ModeloCategoria(
      idRegistro: json["Id_registro"],
      idUser: json["Id_User"],
      descripcion: json["Descripcion"],
      cantidad: json["Cantidad"],
      fechaPago: json["FechaPago"],
      image: json["image"],
      facturado: json["Facturado"]);
  factory ModeloCategoria.fromJson(Map<String, dynamic> json) =>
      ModeloCategoria(
          idRegistro: json["Id_registro"],
          idUser: json["Id_User"],
          descripcion: json["Descripcion"],
          cantidad: json["Cantidad"],
          fechaPago: json["FechaPago"],
          image: json["image"],
          facturado: json["Facturado"]);

  Map<String, dynamic> toMap() => {
        "Id_registro": idRegistro,
        "Id_User": idUser,
        "Descripcion": descripcion,
        "Cantidad": cantidad,
        "FechaPago": fechaPago,
        "image": image,
        "Facturado": facturado,
      };
}
