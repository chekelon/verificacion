import 'package:flutter/material.dart';
import 'package:verificacion/models/ResponseReporteRS.dart';

class ReporteServicioProvider extends ChangeNotifier {
  late ReporteServicio _reporteServicio;
  String _diagnostico = "";
  int _idOt = 0;
  int _numero_dispensario = 0;
  String _fechaTerminada = "";
  String _horaTerminada = "";

  ReporteServicio get reporteServicio => _reporteServicio;
  set reporteServicio(ReporteServicio value) {
    _reporteServicio = value;
    notifyListeners();
  }

  String get diagnostico => _diagnostico;
  set diagnostico(String value) {
    _diagnostico = value;
    notifyListeners();
  }

  int get id_ot => _idOt;
  set id_ot(int value) {
    _idOt = value;
    notifyListeners();
  }

  int get numero_dispensario => _numero_dispensario;
  set numero_dispensario(int value) {
    _numero_dispensario = value;
    notifyListeners();
  }

  String get fechaTerminada => _fechaTerminada;
  set fechaTerminada(String value) {
    _fechaTerminada = value;
    notifyListeners();
  }

  String get horaTerminada => _horaTerminada;
  set horaTerminada(String value) {
    _horaTerminada = value;
    notifyListeners();
  }
}
