import 'dart:async';

import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/ReceivedNotification.dart';
import 'package:dicertur_quistococha/src/pages/home.dart';
import 'package:dicertur_quistococha/src/pages/login.dart';
import 'package:dicertur_quistococha/src/pages/splash.dart';
import 'package:dicertur_quistococha/src/pages/tabs/bloc_contador_qr.dart';
import 'package:dicertur_quistococha/src/pushProvider/push_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  final GlobalKey<NavigatorState> navigatorkey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    //linea de notificacion , descomentar para compilar
    PushNotificationService.messagesStream.listen((event) {
      print('cuando la app esta abierta');
      //navigatorkey.currentState.pushNamed('notificationPage', arguments: event);
      navigatorkey.currentState!.pushNamed('solicitudes', arguments: event);
    });
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    super.initState();
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream.listen(
      (ReceivedNotification receivedNotification) async {
        await showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: receivedNotification.title != null ? Text(receivedNotification.title!) : null,
            content: receivedNotification.body != null ? Text(receivedNotification.body!) : null,
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () async {
                  await flutterLocalNotificationsPlugin.cancelAll();

                  print('_configureDidReceiveLocalNotificationSubject');
                  Navigator.of(context, rootNavigator: true).pop();
                  await navigatorkey.currentState!.pushNamed('onboarding', arguments: receivedNotification.payload);
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        //esto funciona cuando tocas la notificacion que se genero con la app abierta
        await flutterLocalNotificationsPlugin.cancelAll();
        print('esta te lleva la pantalla seleccionada cuando la app esta abierta $payload');
        //await navigatorkey.currentState.pushNamed('notificationPage', arguments: payload);
        await navigatorkey.currentState!.pushNamed('solicitudes', arguments: payload);
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
            builder: (BuildContext context, Widget ? child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                  data: data.copyWith(textScaleFactor: data.textScaleFactor > 2.0 ? 1.2 : data.textScaleFactor),
                  child: child!,
                );
              },

              localizationsDelegates: [
                 
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('es'),
                const Locale('es', 'ES'), // Spanish, no country code
                //const Locale('en', 'EN'), // English, no country code
              ],
              localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
                //print("change language");
                return locale;
              },theme: ThemeData(
                primarySwatch: Colors.green,
                scaffoldBackgroundColor: Color(0xFFF2F7F5),
                canvasColor: Colors.transparent,
                textTheme: GoogleFonts.poppinsTextTheme(),
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
