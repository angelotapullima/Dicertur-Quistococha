import 'dart:async';

import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/home.dart';
import 'package:dicertur_quistococha/src/pages/login.dart';
import 'package:dicertur_quistococha/src/pages/old/agregar_acompa%C3%B1ante.dart';
import 'package:dicertur_quistococha/src/pages/old/metodo_pago.dart';
import 'package:dicertur_quistococha/src/pages/old/new_account.dart';
import 'package:dicertur_quistococha/src/pages/old/selecciona_horario.dart';
import 'package:dicertur_quistococha/src/pages/splash.dart';
import 'package:dicertur_quistococha/src/pushProvider/push_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {

  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      //

    /*   await loadImage('assets/splash/1K.webp');
      await loadImage('assets/splash/2Y.webp');
      await loadImage('assets/splash/3Y.webp');
      await loadImage('assets/img/pasto2.webp'); */

    /*   final prefs = new Preferences();
      final prefsBufiPaymets = new PreferencesBufiPayments(); 

      await prefs.initPrefs();
      await prefsBufiPaymets.initPrefs();*/

      final firebase = FirebaseInstance();

      firebase.initConfig();

      runApp(MyApp());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
  /* 
  runApp(MyApp()); */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => MaterialApp(
          title: 'Dicertur',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch:Colors.yellow,
          ),
          initialRoute: 'splash',
          routes: {
            'splash': (BuildContext context) => Splash(),
            'login': (BuildContext context) => Login(),
            'newAccount': (BuildContext context) => NewAccount(),
            'home': (BuildContext context) => HomePage(),
            'AgregarCompany': (BuildContext context) => AgregarCompany(),
            'SeleccionaHorario': (BuildContext context) => SeleccionaHorario(),
            'MetodoPago': (BuildContext context) => MetodoPago(),
          },

          //home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}
