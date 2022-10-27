import 'package:flutter/material.dart';
import 'package:verificacion/models/ResponseDispe.dart';

class OrdenTrabajoProvider extends ChangeNotifier {
  late List<Dispensario> _dispensarios;
  late Estacion _estacion;

  List<Dispensario> get dispensarios => _dispensarios;
  set dispensarios(List<Dispensario> value) {
    _dispensarios = value;
    notifyListeners();
  }

  Estacion get estacion => _estacion;
  set estacion(Estacion value) {
    _estacion = value;
    notifyListeners();
  }
}
