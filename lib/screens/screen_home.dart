import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:verificacion/models/ResponseDispe.dart';
import 'package:verificacion/models/ResponseLogin.dart';
import 'package:verificacion/providers/login_form_provider.dart';
import 'package:verificacion/providers/ordenTrabajo_provider.dart';
import 'package:verificacion/screens/screen_ordenTrabajo.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  String barcode = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LoginFormProvider data = Provider.of<LoginFormProvider>(context);
    OrdenTrabajoProvider ordenT = Provider.of<OrdenTrabajoProvider>(context);
    return Scaffold(
      body: Column(children: [
        Container(
          width: width,
          height: height * .5,
          //color: Colors.pink,
          child: Stack(children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: 250,
                height: 250,
                child: data.empleado.foto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.network(
                          "https://innovacion.dgl.com.mx/prueba/ezequiel/${data.empleado.foto}",
                          fit: BoxFit.cover,
                          loadingBuilder: ((BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }),
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.asset(
                          'assets/foto_empty.jpeg',
                          fit: BoxFit.fill,
                        ),
                      ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(130),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                child: Column(
                  children: [
                    Text(
                      "${data.empleado.nombre} ${data.empleado.apepat} ${data.empleado.apemat}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "${data.empleado.puesto}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(" #  ${data.empleado.numTecnico ?? "Sin numero"}",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300))
                  ],
                ),
              ),
            )
          ]),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: width,
          height: height * .5,
          //color: Colors.brown,
          child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: data.ordenes.length,
              itemBuilder: ((context, index) {
                OrdenTrabajo orden = data.ordenes[index];
                return Card(
                  elevation: 5.0,
                  child: Stack(children: [
                    ListTile(
                      leading: SizedBox(
                        width: 100,
                        height: 100,
                      ),
                      title: Text('${orden.nombreOpt}'),
                      subtitle: Text('${orden.tipo}'),
                      isThreeLine: true,
                    ),
                    Container(
                      width: 140,
                      height: 120,
                      child: Stack(fit: StackFit.loose, children: [
                        Image.asset(
                          'assets/gas-station.png',
                        ),
                      ]),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(27, 119, 196, 1),
                          //borderRadius: BorderRadius.circular(20),
                          /* boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                ),
                              ] */
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: ((_) => AlertDialog(
                                      title: Text('Elija una opcion.'),
                                      content: Container(
                                        width: width * .70,
                                        height: height * .25,
                                        child: LayoutBuilder(
                                          builder: (BuildContext, constraints) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                  width:
                                                      constraints.maxWidth * .5,
                                                  height:
                                                      constraints.maxHeight *
                                                          .8,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await _descargarSasisopa(
                                                          orden);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'assets/file.png',
                                                          width: 80,
                                                          height: 80,
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          'SASISOPA',
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(),
                                                ),
                                                Container(
                                                  width:
                                                      constraints.maxWidth * .5,
                                                  height:
                                                      constraints.maxHeight *
                                                          .8,
                                                  child: GestureDetector(
                                                    onTap: (() {
                                                      _scanQr(context, orden,
                                                          ordenT);
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'assets/check-list.png',
                                                          width: 120,
                                                          height: 120,
                                                        ),
                                                        Text(
                                                          'Empezar Revision',
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    )));
                          },
                          child: Center(
                            child: Icon(
                              Icons.qr_code_scanner,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              })),
        )
      ]),
    );
  }

  Future<bool> _descargarSasisopa(OrdenTrabajo orden) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        //Android
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          print(directory.path);
          String newPath = "";

          ///storage/emulated/0/Android/data/com.example.verificacion/files
          List<String> folders = directory.path.split("/");
          for (var i = 1; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Verificacion";
          directory = Directory(newPath);
          EasyLoading.show(
              status: 'Descargando', maskType: EasyLoadingMaskType.black);
          print(directory.path);
        } else {
          return false;
        }
      } else {
        //IOS
        if (await _requestPermission(Permission.photos)) {
          directory = (await getExternalStorageDirectory())!;
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path);

        var savePath = join(saveFile.path, "${orden.nombreOpt}_sasisopa.pdf");

        var response = await Dio().download(
          'https://innovacion.dgl.com.mx/prueba/ezequiel/Reportes/print_SASISOPA/${orden.idOt}',
          savePath,
          onReceiveProgress: (count, total) {
            if (count / total == 1.0) {
              EasyLoading.showSuccess('Listo',
                  maskType: EasyLoadingMaskType.black);
            } else {
              EasyLoading.showProgress(count / total,
                  maskType: EasyLoadingMaskType.black);
            }
          },
        );

        OpenFile.open(savePath);
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(savePath);
        }
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> _scanQr(
      context, OrdenTrabajo orden, OrdenTrabajoProvider ordenT) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      barcode = barcodeScanRes;
      print("Codigo del QR:${barcodeScanRes}");

      var url =
          Uri.https('innovacion.dgl.com.mx', '/prueba/ezequiel/api/validarQr');

      var response = await http.post(url, body: {
        'qr': barcode,
        'id_ot': orden.idOt.toString(),
        'estatus': "EN PROCESO"
      });

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        if (res['estatus']) {
          var url = Uri.https(
              'innovacion.dgl.com.mx', '/prueba/ezequiel/api/getDispensario');

          var response = await http.post(url, body: {
            'id_ot': orden.idOt.toString(),
            'idestacion': orden.idestacion.toString()
          });

          if (response.statusCode == 200) {
            ResponseDispensarios resp =
                ResponseDispensarios.fromJson(json.decode(response.body));

            ordenT.dispensarios = resp.dispensario!;
            ordenT.estacion = resp.estacion!;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ScreenOrdenTrabajo(resp.estacion!, resp.dispensario!)));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red, content: Text("${res['msg']}")),
          );
        }
        return res['estatus'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Container(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('Ocurrio un error...'), Text(response.body)],
                ),
              )),
        );
        return false;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      return false;
    }
  }
}
