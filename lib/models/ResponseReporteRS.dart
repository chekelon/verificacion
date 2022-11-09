import 'dart:convert';

ReporteServicio reporteServicioFromJson(String str) =>
    ReporteServicio.fromJson(json.decode(str));

String reporteServicioToJson(ReporteServicio data) =>
    json.encode(data.toJson());

class ReporteServicio {
  ReporteServicio({
    required this.status,
    required this.idOt,
    required this.folio,
    required this.estatus,
    this.diagnostico,
    required this.numeroDispensario,
    required this.fechaCreacion,
  });

  bool? status;
  String? idOt;
  String? folio;
  String? estatus;
  String? diagnostico;
  int? numeroDispensario;
  String? fechaCreacion;

  factory ReporteServicio.fromJson(Map<String, dynamic> json) =>
      ReporteServicio(
        status: json["status"] == null ? null : json["status"],
        idOt: json["id_ot"] == null ? null : json["id_ot"],
        folio: json["folio"] == null ? null : json["folio"],
        estatus: json["estatus"] == null ? null : json["estatus"],
        diagnostico: json["diagnostico"] == null ? null : json["diagnostico"],
        numeroDispensario: json["numero_dispensario"] == null
            ? null
            : json["numero_dispensario"],
        fechaCreacion:
            json["fecha_creacion"] == null ? null : json["fecha_creacion"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "id_ot": idOt == null ? null : idOt,
        "folio": folio == null ? null : folio,
        "estatus": estatus == null ? null : estatus,
        "diagnostico": diagnostico == null ? null : diagnostico,
        "numero_dispensario":
            numeroDispensario == null ? null : numeroDispensario,
        "fecha_creacion": fechaCreacion == null ? null : fechaCreacion,
      };
}
