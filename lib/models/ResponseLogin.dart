// To parse this JSON data, do
//
//     final loginProvider = loginProviderFromJson(jsonString);

import 'dart:convert';

ResponseLogin loginProviderFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String loginProviderToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    required this.login,
    this.empleado,
    this.ordenTrabajo,
  });

  bool login;
  Empleado? empleado;
  List<OrdenTrabajo>? ordenTrabajo;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        login: json["login"] == null ? null : json["login"],
        empleado: json["empleado"] == null
            ? null
            : Empleado.fromJson(json["empleado"]),
        ordenTrabajo: json["ordenTrabajo"] == null
            ? null
            : List<OrdenTrabajo>.from(
                json["ordenTrabajo"].map((x) => OrdenTrabajo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "login": login == null ? null : login,
        "empleado": empleado == null ? null : empleado!.toJson(),
        "ordenTrabajo": ordenTrabajo == null
            ? null
            : List<dynamic>.from(ordenTrabajo!.map((x) => x.toJson())),
      };
}

class Empleado {
  Empleado({
    required this.numTecnico,
    required this.nombre,
    required this.apepat,
    required this.apemat,
    required this.foto,
    required this.puesto,
  });

  dynamic numTecnico;
  String nombre;
  String apepat;
  String apemat;
  dynamic foto;
  String puesto;

  factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
        numTecnico: json["num_tecnico"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        apepat: json["apepat"] == null ? null : json["apepat"],
        apemat: json["apemat"] == null ? null : json["apemat"],
        foto: json["foto"],
        puesto: json["puesto"] == null ? null : json["puesto"],
      );

  Map<String, dynamic> toJson() => {
        "num_tecnico": numTecnico,
        "nombre": nombre == null ? null : nombre,
        "apepat": apepat == null ? null : apepat,
        "apemat": apemat == null ? null : apemat,
        "foto": foto,
        "puesto": puesto == null ? null : puesto,
      };
}

class OrdenTrabajo {
  OrdenTrabajo({
    required this.idOt,
    required this.estatus,
    required this.nombreOpt,
    required this.permisoCre,
    required this.marca,
    required this.zona,
    required this.idestacion,
    required this.tipo,
  });

  int idOt;
  String estatus;
  String nombreOpt;
  String permisoCre;
  String marca;
  int zona;
  int idestacion;
  String tipo;

  factory OrdenTrabajo.fromJson(Map<String, dynamic> json) => OrdenTrabajo(
        idOt: json["id_ot"] == null ? null : json["id_ot"],
        estatus: json["estatus"] == null ? null : json["estatus"],
        nombreOpt: json["nombre_opt"] == null ? null : json["nombre_opt"],
        permisoCre: json["permiso_cre"] == null ? null : json["permiso_cre"],
        marca: json["marca"] == null ? null : json["marca"],
        zona: json["zona"] == null ? null : json["zona"],
        idestacion: json["idestacion"] == null ? null : json["idestacion"],
        tipo: json["tipo"] == null ? null : json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id_ot": idOt == null ? null : idOt,
        "estatus": estatus == null ? null : estatus,
        "nombre_opt": nombreOpt == null ? null : nombreOpt,
        "permiso_cre": permisoCre == null ? null : permisoCre,
        "marca": marca == null ? null : marca,
        "zona": zona == null ? null : zona,
        "idestacion": idestacion == null ? null : idestacion,
        "tipo": tipo == null ? null : tipo,
      };
}
