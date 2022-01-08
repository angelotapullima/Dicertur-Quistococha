import 'dart:async';

import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/home.dart';
import 'package:dicertur_quistococha/src/pages/login.dart';
import 'package:dicertur_quistococha/src/pages/splash.dart';
import 'package:dicertur_quistococha/src/pages/tabs/bloc_contador_qr.dart';
import 'package:dicertur_quistococha/src/pushProvider/push_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(providers: [
        ChangeNotifierProvider<ContadorQrBloc>(
          create: (_) => ContadorQrBloc(),
        ),
        
      ],
      child: ProviderBloc(
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
              
              'home': (BuildContext context) => HomePage(),
              //'MetodoPago': (BuildContext context) => MetodoPago(),
            },
    
            //home: MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        ),
      ),
    );
  }
}
