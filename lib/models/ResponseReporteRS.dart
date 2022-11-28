import 'dart:convert';

ResponseReporteRs reponseReproteRsFromJson(String str) =>
    ResponseReporteRs.fromJson(json.decode(str));

String reponseReproteRsToJson(ResponseReporteRs data) =>
    json.encode(data.toJson());

class ResponseReporteRs {
  ResponseReporteRs({
    required this.status,
    required this.idOt,
    required this.folio,
    required this.estatus,
    required this.diagnostico,
    required this.numeroDispensario,
    required this.fechaCreacion,
    required this.fechaTerminada,
  });

  bool status;
  String idOt;
  String folio;
  String estatus;
  String? diagnostico;
  int numeroDispensario;
  DateTime? fechaCreacion;
  DateTime? fechaTerminada;

  factory ResponseReporteRs.fromJson(Map<String, dynamic> json) =>
      ResponseReporteRs(
        status: json["status"] == null ? null : json["status"],
        idOt: json["id_ot"] == null ? null : json["id_ot"],
        folio: json["folio"] == null ? null : json["folio"],
        estatus: json["estatus"] == null ? null : json["estatus"],
        diagnostico: json["diagnostico"] == null ? null : json["diagnostico"],
        numeroDispensario: json["numero_dispensario"] == null
            ? null
            : json["numero_dispensario"],
        fechaCreacion: json["fecha_creacion"] == null
            ? null
            : DateTime.parse(json["fecha_creacion"]),
        fechaTerminada: json["fecha_terminada"] == null
            ? null
            : DateTime.parse(json["fecha_terminada"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "id_ot": idOt == null ? null : idOt,
        "folio": folio == null ? null : folio,
        "estatus": estatus == null ? null : estatus,
        "diagnostico": diagnostico,
        "numero_dispensario":
            numeroDispensario == null ? null : numeroDispensario,
        "fecha_creacion": fechaCreacion == null ? null : fechaCreacion,
        "fecha_terminada": fechaTerminada == null ? null : fechaTerminada,
      };
}
