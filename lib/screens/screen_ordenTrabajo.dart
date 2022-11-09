import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:verificacion/models/ResponseDispe.dart';
import 'package:verificacion/models/ResponseReporteRS.dart';
import 'package:verificacion/providers/reporte_servicio_provider.dart';
import 'package:verificacion/screens/screen_BE.dart';
import 'package:verificacion/screens/screen_RI.dart';
import 'package:verificacion/screens/screen_RS.dart';
import 'package:http/http.dart' as http;

class ScreenOrdenTrabajo extends StatelessWidget {
  Estacion estacion;
  List<Dispensario> dispensario;
  ScreenOrdenTrabajo(this.estacion, this.dispensario);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ReporteServicioProvider reporte =
        Provider.of<ReporteServicioProvider>(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * .5,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: constraints.maxWidth,
                          child: Column(
                            children: [
                              Text("${estacion.nombreOpt}"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topCenter,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * .5,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _mostrarDipensarios(
                          dispensario, context, width, height, reporte),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _mostrarDipensarios(List<Dispensario> disp, context, width,
      height, ReporteServicioProvider reporte) {
    List<Widget> dispensarios = [];

    for (var element in disp) {
      dispensarios.add(GestureDetector(
        onTap: () {
          print("Num Disp: ${element.numeroDispensario}");

          showDialog(
              context: context,
              builder: (((context) => AlertDialog(
                    title: Text("Elije el reporte"),
                    content: Container(
                        width: width * .90,
                        height: height * .25,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            print(constraints.maxWidth);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    ReporteServicio? resp =
                                        await _crearReporteServicio(
                                            element, reporte, context);
                                    if (resp!.status!) {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ScreenRS(element)));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Container(
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('Ocurrio un error...')
                                                ],
                                              ),
                                            )),
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[100]),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/check-list.png',
                                          width: 60,
                                          height: 60,
                                        ),
                                        Text(
                                          'Reporte de Servicio',
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ScreenBE()));
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[100]),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/check-list.png',
                                          width: 60,
                                          height: 60,
                                        ),
                                        Text(
                                          'Bitacora de Eventos',
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ScreenRI()));
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[100]),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/check-list.png',
                                          width: 60,
                                          height: 60,
                                        ),
                                        Text(
                                          'Retencion de Informacion',
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        )),
                  ))));
        },
        child: Container(
          width: 100.0,
          height: 120.0,
          margin: EdgeInsets.only(bottom: 10, right: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${element.numeroDispensario}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  child: Icon(
                    Icons.local_gas_station,
                    size: 52,
                  ),
                ),
              ),
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      child: Text("RS"),
                      decoration: BoxDecoration(
                          color: element.rs == "PENDIENTE"
                              ? Colors.white
                              : element.rs == "EN PROCESO"
                                  ? Colors.amber
                                  : Colors.green,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1.0,
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      child: Text("BE"),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(
                            width: 1.0,
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      child: Text("RI"),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1.0,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ));
    }

    return dispensarios;
  }

  Future<ReporteServicio?> _crearReporteServicio(
      Dispensario disp, ReporteServicioProvider reporte, context) async {
    var url = Uri.https(
        'innovacion.dgl.com.mx', '/prueba/ezequiel/api/createReporte_Servicio');

    var response = await http.post(url, body: {
      'num_disp': disp.numeroDispensario.toString(),
      'id_ot': disp.idOt.toString(),
    });
    ReporteServicio resp;
    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      ReporteServicio resp = ReporteServicio.fromJson(res);
      reporte.reporteServicio = resp;

      return resp;
    } else {
      return null;
    }
  }
}
