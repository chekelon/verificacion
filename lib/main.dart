import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:verificacion/providers/login_form_provider.dart';
import 'package:verificacion/providers/ordenTrabajo_provider.dart';
import 'package:verificacion/screens/screen_RS.dart';
import 'package:verificacion/screens/screen_home.dart';
import 'package:verificacion/screens/screen_login.dart';
import 'package:verificacion/screens/screen_ordenTrabajo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => OrdenTrabajoProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (_) => ScreenLogin(),
          'home': (_) => ScreenHome(),
        },
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: const Center(
            child: Text('Hello World'),
          ),
        ),
        builder: EasyLoading.init(),
      ),
    );
  }
}
