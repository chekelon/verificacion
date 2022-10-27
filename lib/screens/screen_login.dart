import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:verificacion/models/ResponseLogin.dart';
import 'package:verificacion/providers/login_form_provider.dart';
import 'package:verificacion/ui/input_Decorations.dart';

import 'package:http/http.dart' as http;

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    LoginFormProvider data = Provider.of<LoginFormProvider>(context);
    return Scaffold(
        body: Stack(children: [
      Container(
        width: width,
        height: height * .6,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/logo_principal.png'),
                fit: BoxFit.contain)),
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * .5,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              width: width,
              height: height * .5,
              child: Form(
                  key: data.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecorations.authInputDecoration(
                            colorsborder: Colors.grey,
                            labelText: 'Usuario',
                            helperText: '',
                            hintText: '',
                            radius: 10,
                            suffixIcon: Icons.person),
                        onChanged: (value) {
                          if (value != "") {
                            data.user = value;
                          }
                        },
                        validator: (value) {
                          if (value != null) {
                            return null;
                          } else {
                            return 'Escribe tu usuario ..';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onEditingComplete: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          await _submitForm(context, data);
                        },
                        decoration: InputDecorations.authInputDecoration(
                            colorsborder: Colors.grey,
                            labelText: 'Contraseña',
                            helperText: '',
                            hintText: '',
                            radius: 10,
                            suffixIcon: Icons.lock),
                        onChanged: (value) {
                          if (value != "") {
                            data.pass = value;
                          }
                        },
                        validator: (value) {
                          if (value != null) {
                            return null;
                          } else {
                            return 'Escribe tu contraseña ..';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                          child: Container(
                            alignment: Alignment.center,
                            width: width,
                            height: 50,
                            child: Text(
                              'Entrar',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(27, 119, 196, 1),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                          ),
                          onPressed: () {
                            _submitForm(context, data);
                          }),
                      Expanded(child: Container()),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/logo-verif.png',
                              width: 50,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              'assets/logo_simsa.png',
                              width: 55,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    ]));
  }

  _submitForm(
    BuildContext context,
    LoginFormProvider data,
  ) async {
    if (data.isValidForm()) {
      EasyLoading.show(
          status: 'loading...', maskType: EasyLoadingMaskType.black);
      ResponseLogin? empleado = await _postLogin(data);

      if (empleado != null) {
        if (empleado.login) {
          EasyLoading.showSuccess('Success',
              maskType: EasyLoadingMaskType.black);

          data.ordenes = empleado.ordenTrabajo!;
          data.empleado = empleado.empleado!;

          await Future.delayed(Duration(seconds: 2));
          EasyLoading.dismiss();
          Navigator.pushNamed(context, 'home');
        } else {
          EasyLoading.showError('Las credenciales son incorrectas..',
              maskType: EasyLoadingMaskType.black);
        }
      }
    } else {}
  }

  _postLogin(LoginFormProvider data) async {
    var url = Uri.https('innovacion.dgl.com.mx', '/prueba/ezequiel/api/login');

    var response =
        await http.post(url, body: {'user': data.user, 'pass': data.pass});

    if (response.statusCode == 200) {
      ResponseLogin resLogin =
          ResponseLogin.fromJson(json.decode(response.body));

      return resLogin;
    }
    return null;
  }
}
