import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verificacion/models/ResponseDispe.dart';
import 'package:verificacion/providers/ordenTrabajo_provider.dart';
import 'package:verificacion/providers/reporte_servicio_provider.dart';
import 'package:http/http.dart' as http;

class ScreenRS extends StatelessWidget {
  Dispensario dispensario;

  ScreenRS(this.dispensario);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OrdenTrabajoProvider OrdenT = Provider.of<OrdenTrabajoProvider>(context);
    DateTime tiempo = DateTime.now();
    ReporteServicioProvider reporte =
        Provider.of<ReporteServicioProvider>(context);

    DateTime timeInicio =
        DateTime.parse(reporte.reporteServicio.fechaCreacion!);
    var horaInicio = timeInicio.hour;
    var minInicio = timeInicio.minute;
    /*DateTime timeFin = DateTime.parse(reporte.reporteServicio.fechaTermindada!);
    var horaFin = timeFin.hour;
    var minFin = timeFin.minute;*/

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300.withOpacity(.5),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: width,
              margin: EdgeInsets.all(10),
              //color: Colors.red.withOpacity(.2),
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reporte de Servicio",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 10.0,
                      ),
                      margin: EdgeInsets.only(left: width * .55),
                      alignment: Alignment.topRight,
                      width: width * .3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Folio",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${reporte.reporteServicio.folio}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("${OrdenT.estacion.nombreOpt}"),
                    Text("${OrdenT.estacion.rs}"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //color: Colors.grey,
                      width: width,
                      height: (height * .3) * .35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dispensario ${dispensario.numeroDispensario}",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Marca: ${dispensario.marca} "),
                          Text("Modelo: ${dispensario.modelo}"),
                          Text("Serie: ${dispensario.serie}")
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width,
                      //color: Colors.orange.withOpacity(.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              "Inicio ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                              width: width * .38,
                              child: DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: 'd, MMM, yyyy',
                                initialValue:
                                    reporte.reporteServicio.fechaCreacion !=
                                            null
                                        ? reporte.reporteServicio.fechaCreacion
                                        : DateTime.now().toString(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2023),
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  icon: Icon(
                                    Icons.event,
                                    size: 32,
                                    color: Colors.blue.shade600,
                                  ),
                                ),
                                fieldLabelText: 'Fecha',
                                selectableDayPredicate: (date) {
                                  if (date.weekday == 6 || date.weekday == 7) {
                                    return false;
                                  }
                                  return true;
                                },
                                onChanged: (value) => print("Changed  $value"),
                                validator: ((value) {
                                  print("validator $value");
                                  return null;
                                }),
                                onSaved: ((newValue) =>
                                    print("Saved : ${newValue}")),
                              )),
                          Container(
                              width: width * .35,
                              child: DateTimePicker(
                                type: DateTimePickerType.time,
                                dateMask: 'hh:mm',
                                initialValue:
                                    reporte.reporteServicio.fechaCreacion !=
                                            null
                                        ? "$horaInicio:$minInicio"
                                        : "",
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2023),
                                readOnly: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  icon: Icon(
                                    Icons.access_time_outlined,
                                    size: 32,
                                    color: Colors.blue.shade600,
                                  ),
                                ),
                                fieldLabelText: 'Fecha',
                                selectableDayPredicate: (date) {
                                  if (date.weekday == 6 || date.weekday == 7) {
                                    return false;
                                  }
                                  return true;
                                },
                                onChanged: (value) {
                                  print("Changed  $value");
                                },
                                validator: ((value) {
                                  print("validator $value");
                                  return null;
                                }),
                                onSaved: ((newValue) =>
                                    print("Saved : ${newValue}")),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: width,
              margin: EdgeInsets.all(10),
              //height: height * .7,
              //color: Colors.green.withOpacity(.2),
              child: LayoutBuilder(builder: (context, BoxConstraints) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: reporte.reporteServicio.diagnostico,
                          onChanged: (value) {
                            reporte.diagnostico = value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              focusedBorder: InputBorder.none,
                              label: Text("Diagnostico y servicio realizado ")),
                          maxLines: 15,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: width,
                        //color: Colors.orange.withOpacity(.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "Final ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                                width: width * .38,
                                child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'd, MMM, yyyy',
                                  initialValue: reporte.reporteServicio
                                              .fechaTermindada !=
                                          null
                                      ? reporte.reporteServicio.fechaTermindada
                                      : DateTime.now().toString(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2023),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    icon: Icon(
                                      Icons.event,
                                      size: 32,
                                      color: Colors.blue.shade600,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.event,
                                    size: 32,
                                    color: Colors.blue.shade600,
                                  ),
                                  fieldLabelText: 'Fecha',
                                  selectableDayPredicate: (date) {
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }
                                    return true;
                                  },
                                  onChanged: (value) =>
                                      print("Changed  $value"),
                                  validator: ((value) {
                                    print("validator $value");
                                    return null;
                                  }),
                                  onSaved: ((newValue) {
                                    print("Saved : ${newValue}");
                                    reporte.fechaTerminada = newValue!;
                                  }),
                                )),
                            Container(
                                width: width * .35,
                                child: DateTimePicker(
                                  type: DateTimePickerType.time,
                                  dateMask: 'hh:mm:s',
                                  initialValue: /* horaFin.toString() +
                                      ":" +
                                      minFin.toString()*/
                                      "",
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2023),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    icon: Icon(
                                      Icons.access_time_outlined,
                                      size: 32,
                                      color: Colors.blue.shade600,
                                    ),
                                  ),
                                  fieldLabelText: 'Fecha',
                                  selectableDayPredicate: (date) {
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }
                                    return true;
                                  },
                                  onChanged: (value) =>
                                      print("Changed  $value"),
                                  validator: ((value) {
                                    print("validator $value");
                                    return null;
                                  }),
                                  onSaved: ((newValue) {
                                    print("Saved : ${newValue}");
                                    reporte.horaTerminada = newValue!;
                                  }),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              minWidth: 150,
                              height: 50,
                              color: Colors.blue.shade600,
                              child: Text(
                                "Guardar",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 10,
                              onLongPress: () async {
                                var res = await _guardar(
                                  reporte.diagnostico,
                                  reporte.reporteServicio.idOt!,
                                  reporte.reporteServicio.numeroDispensario!,
                                );

                                if (res) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content:
                                            Text("Se guardo correctamente...")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("No se pudo guardar...")),
                                  );
                                }
                              },
                              onPressed: () {},
                            ),
                            MaterialButton(
                              minWidth: 150,
                              height: 50,
                              color: Colors.blue.shade600,
                              child: Text("Terminado",
                                  style: TextStyle(color: Colors.white)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 10,
                              onLongPress: () async {
                                var res = await _guardarTerminado(
                                    reporte.diagnostico,
                                    reporte.reporteServicio.idOt!,
                                    reporte.reporteServicio.numeroDispensario!);

                                if (res) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content:
                                            Text("Se guardo correctamente...")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("No se pudo guardar...")),
                                  );
                                }
                              },
                              onPressed: () {},
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            )
          ]),
        ),
      ),
    );
  }

  Future<bool> _guardar(
      String diagnostico, String id_ot, int numero_dispensario) async {
    print("Guardar: $diagnostico ");
    print("Guardar: $id_ot-$numero_dispensario");

    var url = Uri.https('innovacion.dgl.com.mx',
        '/prueba/ezequiel/api/guardarReporte_Servicio');

    var response = await http.post(url, body: {
      'num_disp': numero_dispensario.toString(),
      'id_ot': id_ot,
      'diagnostico': diagnostico
    });

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res['estatus']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> _guardarTerminado(
      String diagnostico, String id_ot, int numero_dispensario) async {
    var url = Uri.https('innovacion.dgl.com.mx',
        '/prueba/ezequiel/api/guardarReporte_Servicio');

    var response = await http.post(url, body: {
      'num_disp': numero_dispensario.toString(),
      'id_ot': id_ot,
      'diagnostico': diagnostico,
      'fechaTerminada': DateTime.now().toString()
    });

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res['estatus']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
