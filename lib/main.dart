import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/home.dart';
import 'package:dicertur_quistococha/src/pages/login.dart';
import 'package:dicertur_quistococha/src/pages/new_account.dart';
import 'package:dicertur_quistococha/src/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
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
            primarySwatch: Colors.blue,
          ),
          initialRoute: 'splash',
          routes: {
            'splash': (BuildContext context) => Splash(),
            'login': (BuildContext context) => Login(),
            'newAccount': (BuildContext context) => NewAccount(),
            'home': (BuildContext context) => HomePage(),
          },

          //home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}
