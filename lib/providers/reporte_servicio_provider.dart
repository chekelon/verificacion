import 'package:flutter/material.dart';
import 'package:verificacion/models/ResponseReporteRS.dart';

class ReporteServicioProvider extends ChangeNotifier {
  late ReporteServicio _reporteServicio;

  ReporteServicio get reporteServicio => _reporteServicio;
  set reporteServicio(ReporteServicio value) {
    _reporteServicio = value;
    notifyListeners();
  }
}
