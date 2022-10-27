// To parse this JSON data, do
//
//     final responseDispensarios = responseDispensariosFromJson(jsonString);

import 'dart:convert';

ResponseDispensarios responseDispensariosFromJson(String str) =>
    ResponseDispensarios.fromJson(json.decode(str));

String responseDispensariosToJson(ResponseDispensarios data) =>
    json.encode(data.toJson());

class ResponseDispensarios {
  ResponseDispensarios({
    required this.dispensario,
    required this.estacion,
  });

  List<Dispensario>? dispensario;
  Estacion? estacion;

  factory ResponseDispensarios.fromJson(Map<String, dynamic> json) =>
      ResponseDispensarios(
        dispensario: json["dispensario"] == null
            ? null
            : List<Dispensario>.from(
                json["dispensario"].map((x) => Dispensario.fromJson(x))),
        estacion: json["estacion"] == null
            ? null
            : Estacion.fromJson(json["estacion"]),
      );

  Map<String, dynamic> toJson() => {
        "dispensario": dispensario == null
            ? null
            : List<dynamic>.from(dispensario!.map((x) => x.toJson())),
        "estacion": estacion == null ? null : estacion!.toJson(),
      };
}

class Dispensario {
  Dispensario({
    required this.idOt,
    required this.qr,
    required this.estatus,
    required this.modelo,
    required this.marca,
    required this.mangueras,
    required this.productos,
    required this.flujo,
    required this.numeroDispensario,
    required this.serie,
    required this.nombreEstacion,
  });

  int idOt;
  String qr;
  String estatus;
  String modelo;
  String marca;
  String mangueras;
  int productos;
  String flujo;
  String numeroDispensario;
  String serie;
  String nombreEstacion;

  factory Dispensario.fromJson(Map<String, dynamic> json) => Dispensario(
        idOt: json["id_ot"] == null ? null : json["id_ot"],
        qr: json["qr"] == null ? null : json["qr"],
        estatus: json["estatus"] == null ? null : json["estatus"],
        modelo: json["modelo"] == null ? null : json["modelo"],
        marca: json["marca"] == null ? null : json["marca"],
        mangueras: json["mangueras"] == null ? null : json["mangueras"],
        productos: json["productos"] == null ? null : json["productos"],
        flujo: json["flujo"] == null ? null : json["flujo"],
        numeroDispensario: json["numero_dispensario"] == null
            ? null
            : json["numero_dispensario"],
        serie: json["serie"] == null ? null : json["serie"],
        nombreEstacion:
            json["nombre_estacion"] == null ? null : json["nombre_estacion"],
      );

  Map<String, dynamic> toJson() => {
        "id_ot": idOt == null ? null : idOt,
        "qr": qr == null ? null : qr,
        "estatus": estatus == null ? null : estatus,
        "modelo": modelo == null ? null : modelo,
        "marca": marca == null ? null : marca,
        "mangueras": mangueras == null ? null : mangueras,
        "productos": productos == null ? null : productos,
        "flujo": flujo == null ? null : flujo,
        "numero_dispensario":
            numeroDispensario == null ? null : numeroDispensario,
        "serie": serie == null ? null : serie,
        "nombre_estacion": nombreEstacion == null ? null : nombreEstacion,
      };
}

class Estacion {
  Estacion({
    required this.nombreOpt,
    required this.nombreEstacion,
    required this.numEstacion,
    required this.rs,
    required this.calle,
    required this.numeroInt,
    required this.colonia,
    required this.ciudad,
    required this.estado,
    required this.cp,
  });

  String nombreOpt;
  String nombreEstacion;
  String numEstacion;
  String rs;
  String calle;
  String numeroInt;
  String colonia;
  String ciudad;
  String estado;
  String cp;

  factory Estacion.fromJson(Map<String, dynamic> json) => Estacion(
        nombreOpt: json["nombre_opt"] == null ? null : json["nombre_opt"],
        nombreEstacion:
            json["nombre_estacion"] == null ? null : json["nombre_estacion"],
        numEstacion: json["num_estacion"] == null ? null : json["num_estacion"],
        rs: json["rs"] == null ? null : json["rs"],
        calle: json["calle"] == null ? null : json["calle"],
        numeroInt: json["numeroInt"] == null ? null : json["numeroInt"],
        colonia: json["colonia"] == null ? null : json["colonia"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
        estado: json["estado"] == null ? null : json["estado"],
        cp: json["cp"] == null ? null : json["cp"],
      );

  Map<String, dynamic> toJson() => {
        "nombre_opt": nombreOpt == null ? null : nombreOpt,
        "nombre_estacion": nombreEstacion == null ? null : nombreEstacion,
        "num_estacion": numEstacion == null ? null : numEstacion,
        "rs": rs == null ? null : rs,
        "calle": calle == null ? null : calle,
        "numeroInt": numeroInt == null ? null : numeroInt,
        "colonia": colonia == null ? null : colonia,
        "ciudad": ciudad == null ? null : ciudad,
        "estado": estado == null ? null : estado,
        "cp": cp == null ? null : cp,
      };
}
