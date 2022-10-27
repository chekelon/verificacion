import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verificacion/models/ResponseDispe.dart';
import 'package:verificacion/providers/ordenTrabajo_provider.dart';

class ScreenRS extends StatelessWidget {
  Dispensario dispensario;

  ScreenRS(this.dispensario);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OrdenTrabajoProvider OrdenT = Provider.of<OrdenTrabajoProvider>(context);
    DateTime tiempo = DateTime.now();

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
                                initialValue: DateTime.now().toString(),
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
                                initialValue: '',
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
                                onChanged: (value) => print("Changed  $value"),
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
                                  initialValue: DateTime.now().toString(),
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
                                  onSaved: ((newValue) =>
                                      print("Saved : ${newValue}")),
                                )),
                            Container(
                                width: width * .35,
                                child: DateTimePicker(
                                  type: DateTimePickerType.time,
                                  dateMask: 'hh:mm:s',
                                  /* initialValue: tiempo.hour.toString() +
                                  ":" +
                                  tiempo.minute.toString(), */
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
                                  onSaved: ((newValue) =>
                                      print("Saved : ${newValue}")),
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
                              onLongPress: () {},
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
                              onLongPress: () {},
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
}
