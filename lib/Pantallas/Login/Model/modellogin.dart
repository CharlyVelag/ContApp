// To parse this JSON data, do
//
//     final modeloLoginUser = modeloLoginUserFromMap(jsonString);

import 'dart:convert';

List<ModeloLoginUser> modeloLoginUserFromMap(String str) =>
    List<ModeloLoginUser>.from(
        json.decode(str).map((x) => ModeloLoginUser.fromMap(x)));

String modeloLoginUserToMap(List<ModeloLoginUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<ModeloLoginUser> modeloUserFromJson(String str) =>
    List<ModeloLoginUser>.from(
        json.decode(str).map((x) => ModeloLoginUser.fromJson(x)));

class ModeloLoginUser {
  String idUser;
  String nombre;
  String mailOrFacebookId;
  String email;
  String password;
  String activo;
  String telefono;
  String infoCompleta;

  ModeloLoginUser({
    required this.idUser,
    required this.nombre,
    required this.mailOrFacebookId,
    required this.email,
    required this.password,
    required this.activo,
    required this.telefono,
    required this.infoCompleta,
  });

  factory ModeloLoginUser.fromMap(Map<String, dynamic> json) => ModeloLoginUser(
        idUser: json["idUser"],
        nombre: json["Nombre"],
        mailOrFacebookId: json["mail_or_FacebookId"],
        email: json["email"],
        password: json["password"],
        activo: json["activo"],
        telefono: json["Telefono"],
        infoCompleta: json["infoCompleta"],
      );

  factory ModeloLoginUser.fromJson(Map<String, dynamic> json) =>
      ModeloLoginUser(
        idUser: json["idUser"],
        nombre: json["Nombre"],
        mailOrFacebookId: json["mail_or_FacebookId"],
        email: json["email"],
        password: json["password"],
        activo: json["activo"],
        telefono: json["Telefono"],
        infoCompleta: json["infoCompleta"],
      );

  Map<String, dynamic> toMap() => {
        "idUser": idUser,
        "Nombre": nombre,
        "mail_or_FacebookId": mailOrFacebookId,
        "email": email,
        "password": password,
        "activo": activo,
        "Telefono": telefono,
        "infoCompleta": infoCompleta,
      };
}
