import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'login');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(),
          Container(
            transform: Matrix4.translationValues(-ScreenUtil().setWidth(40), -ScreenUtil().setHeight(40), 0),
            width: ScreenUtil().setWidth(402),
            height: ScreenUtil().setHeight(418),
            child: SvgPicture.asset(
              'assets/svg/splash_arriba.svg',
            ), //Image.asset('assets/logo_largo.svg'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              transform: Matrix4.translationValues(ScreenUtil().setWidth(40), ScreenUtil().setHeight(40), 0),
              width: ScreenUtil().setWidth(402),
              height: ScreenUtil().setHeight(418),
              child: SvgPicture.asset(
                'assets/svg/splash_abajo.svg',
              ), //Image.asset('assets/logo_largo.svg'),
            ),
          ),
          Center(
            child: Container(
              width: ScreenUtil().setWidth(350),
              height: ScreenUtil().setHeight(350),
              child: Image(
                image: AssetImage('assets/svg/gore2.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
