// To parse this JSON data, do
//
//     final infoUser = infoUserFromJson(jsonString);

import 'dart:convert';

List<InfoUser> modeloLoginUserFromMap(String str) =>
    List<InfoUser>.from(
        json.decode(str).map((x) => InfoUser.fromMap(x)));

String modeloLoginUserToMap(List<InfoUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<InfoUser> modeloUserFromJson(String str) =>
    List<InfoUser>.from(
        json.decode(str).map((x) => InfoUser.fromJson(x)));

class InfoUser {
  String idUser;
  String nombre;
  String mailOrFacebookId;
  String email;
  String password;
  String activo;
  String telefono;
  String infoCompleta;

  InfoUser({
    required this.idUser,
    required this.nombre,
    required this.mailOrFacebookId,
    required this.email,
    required this.password,
    required this.activo,
    required this.telefono,
    required this.infoCompleta,
  });

  factory InfoUser.fromJson(Map<String, dynamic> json) => InfoUser(
        idUser: json["idUser"],
        nombre: json["Nombre"],
        mailOrFacebookId: json["mail_or_FacebookId"],
        email: json["email"],
        password: json["password"],
        activo: json["activo"],
        telefono: json["Telefono"],
        infoCompleta: json["infoCompleta"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "Nombre": nombre,
        "mail_or_FacebookId": mailOrFacebookId,
        "email": email,
        "password": password,
        "activo": activo,
        "Telefono": telefono,
        "infoCompleta": infoCompleta,
      };

       factory InfoUser.fromMap(Map<String, dynamic> json) => InfoUser(
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
