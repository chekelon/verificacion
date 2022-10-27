import 'package:flutter/material.dart';
import 'package:verificacion/models/ResponseLogin.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String _user = '';
  String _pass = '';
  late List<OrdenTrabajo> _ordenes;
  late Empleado _empleado;

  String get user => _user;
  set user(String value) {
    _user = value;
    notifyListeners();
  }

  String get pass => _pass;
  set pass(String value) {
    _pass = value;
    notifyListeners();
  }

  List<OrdenTrabajo> get ordenes => _ordenes;
  set ordenes(List<OrdenTrabajo> value) {
    _ordenes = value;
    notifyListeners();
  }

  Empleado get empleado => _empleado;

  set empleado(Empleado value) {
    _empleado = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
