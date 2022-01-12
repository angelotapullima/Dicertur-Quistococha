import 'dart:io';
import 'package:dicertur_quistococha/src/bloc/bottom_navigation_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/data_user.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/tabs/account.dart';
import 'package:dicertur_quistococha/src/pages/tabs/bloc_contador_qr.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/inicio.dart';
import 'package:dicertur_quistococha/src/pages/tabs/scan_qr.dart';
import 'package:dicertur_quistococha/src/pages/tabs/tickets.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pageList3 = [];
  List<Widget> pageList4 = [];

  @override
  void initState() {
    pageList4.add(InicioPage());
    pageList4.add(Tickets());
    pageList4.add(ScanQR());
    pageList4.add(UserPage());
    pageList3.add(InicioPage());
    pageList3.add(Tickets());
    pageList3.add(UserPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataBloc = ProviderBloc.data(context);
    dataBloc.obtenerUser();
    final bottomBloc = ProviderBloc.bottom(context);

    bottomBloc.changePage(0);

    final responsive = Responsive.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: bottomBloc.selectPageStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
                stream: dataBloc.userStream,
                builder: (context, AsyncSnapshot<UserModel> datos) {
                  if (datos.hasData) {
                    return Stack(
                      children: [
                        (datos.data!.idRoleUser == '2' || datos.data!.idRoleUser == '3')
                            ? Container(
                                padding: EdgeInsets.only(
                                  bottom: kBottomNavigationBarHeight + ScreenUtil().setHeight(20),
                                ),
                                child: IndexedStack(
                                  index: bottomBloc.page,
                                  children: pageList4,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                  bottom: kBottomNavigationBarHeight + ScreenUtil().setHeight(20),
                                ),
                                child: IndexedStack(
                                  index: bottomBloc.page,
                                  children: pageList3,
                                ),
                              ),
                        (datos.data!.idRoleUser == '2' || datos.data!.idRoleUser == '3') ? posi4(bottomBloc, context) : posi3(bottomBloc, context),
                        (int.parse(datos.data!.versionApp!) > int.parse(versionApp2)
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.white,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(
                                              responsive.ip(.5),
                                            ),
                                            height: responsive.ip(10),
                                            child: SvgPicture.asset('assets/svg/LOGO_CAPITAN.svg') //Image.asset('assets/logo_largo.svg'),
                                            ),
                                        SizedBox(
                                          height: responsive.hp(2),
                                        ),
                                        Text(
                                          'Tenemos una nueva versión disponible para tí, descargala ahora !',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: responsive.ip(2),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            //LaunchReview.launch(androidAppId: "com.bufeotec.capitanRemake", iOSAppId: "1568924604");

                                            if (Platform.isAndroid) {
                                              _launchInBrowser('https://play.google.com/store/apps/details?id=com.bufeotec.capitanRemake');
                                            } else {
                                              _launchInBrowser('https://apps.apple.com/us/app/capit%C3%A1n/id1590896023');
                                            }
                                          },
                                          child: Text(
                                            'Actualizar',
                                            style: TextStyle(
                                              fontSize: responsive.ip(2.5),
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container())
                      ],
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            final bottomBloc = ProviderBloc.bottom(context);
            bottomBloc.changePage(0);
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget posi4(BottomNaviBloc bottomBloc, BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10),
          bottom: ScreenUtil().setHeight(10),
        ),
        height: kBottomNavigationBarHeight + ScreenUtil().setHeight(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(0),
            topEnd: Radius.circular(0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                bottomBloc.changePage(0);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setHeight(5),
                    backgroundColor: (bottomBloc.page == 0) ? Color(0xFF65C715) : Colors.transparent,
                  ),
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    child: (bottomBloc.page == 0)
                        ? SvgPicture.asset(
                            'assets/svg/tabs/home_tab.svg',
                            color: Color(0xFF65C715),
                          )
                        : SvgPicture.asset(
                            'assets/svg/tabs/home_tab.svg',
                            color: Color(0xffafafaf),
                          ), //Image.asset('assets/logo_largo.svg'),
                  ),
                  Text(
                    'Inicio',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w600,
                      color: (bottomBloc.page == 0) ? Color(0xFF65C715) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                bottomBloc.changePage(1);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setHeight(5),
                    backgroundColor: (bottomBloc.page == 1) ? Color(0xFF65C715) : Colors.transparent,
                  ),
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    child: (bottomBloc.page == 1)
                        ? SvgPicture.asset(
                            'assets/svg/tabs/ticket_tab.svg',
                            color: Color(0xFF65C715),
                          )
                        : SvgPicture.asset(
                            'assets/svg/tabs/ticket_tab.svg',
                            color: Color(0xffafafaf),
                          ), //Image.assagsset('assets/logo_largo.svg'),
                  ),
                  Text(
                    'Comprar',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w600,
                      color: (bottomBloc.page == 1) ? Color(0xFF65C715) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                final provider = Provider.of<ContadorQrBloc>(context, listen: false);
                provider.changeValorQr(0);
                bottomBloc.changePage(2);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setHeight(5),
                    backgroundColor: (bottomBloc.page == 2) ? Color(0xFF65C715) : Colors.transparent,
                  ),
                  Container(
                    padding: EdgeInsets.all(1),
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    child: (bottomBloc.page == 2)
                        ? SvgPicture.asset(
                            'assets/svg/tabs/qr.svg',
                            color: Color(0xFF65C715),
                          )
                        : SvgPicture.asset(
                            'assets/svg/tabs/qr.svg',
                            color: Color(0xffafafaf),
                          ), //Image.ass//Imagsset('assets/logo_largo.svg'),
                  ),
                  Text(
                    'Escanear',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w600,
                      color: (bottomBloc.page == 2) ? Color(0xFF65C715) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                bottomBloc.changePage(3);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setHeight(5),
                    backgroundColor: (bottomBloc.page == 3) ? Color(0xFF65C715) : Colors.transparent,
                  ),
                  Container(
                    height: ScreenUtil().setSp(28),
                    width: ScreenUtil().setSp(28),
                    child: (bottomBloc.page == 3)
                        ? SvgPicture.asset(
                            'assets/svg/tabs/user_tab.svg',
                            color: Color(0xFF65C715),
                          )
                        : SvgPicture.asset(
                            'assets/svg/tabs/user_tab.svg',
                            color: Color(0xffafafaf),
                          ), //Image.ass//Imagsset('assets/logo_largo.svg'),
                  ),
                  
                  Text(
                    'Cuenta',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      fontWeight: FontWeight.w600,
                      color: (bottomBloc.page == 3) ? Color(0xFF65C715) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget posi3(BottomNaviBloc bottomBloc, BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10),
          bottom: ScreenUtil().setHeight(10),
        ),
        height: kBottomNavigationBarHeight + ScreenUtil().setHeight(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(0),
            topEnd: Radius.circular(0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                bottomBloc.changePage(0);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setHeight(5),
                    backgroundColor: (bottomBloc.page == 0) ? Color(0xffffb240) : Colors.transparent,
                  ),
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    child: (bottomBloc.page == 0)
                        ? SvgPicture.asset(
                            'assets/svg/tabs/home_tab.svg',
                            color: Color(0xffffb240),
                          )
                        : SvgPicture.asset(
                            'assets/svg/tabs/home_tab.svg',
                            color: Color(0xffafafaf),
                          ), //Image.asset('assets/logo_largo.svg'),
                  ),
                  Text(
                    'Inicio',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w600,
                      color: (bottomBloc.page == 0) ? Color(0xffffb240) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                bottomBloc.changePage(1);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setHeight(5),
                    backgroundColor: (bottomBloc.page == 1) ? Color(0xffffb240) : Colors.transparent,
                  ),
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    child: (bottomBloc.page == 1)
                        ? SvgPicture.asset(
                            'assets/svg/tabs/ticket_tab.svg',
                            color: Color(0xffffb240),
                          )
                        : SvgPicture.asset(
                            'assets/svg/tabs/ticket_tab.svg',
                            color: Color(0xffafafaf),
                          ), //Image.assagsset('assets/logo_largo.svg'),
                  ),
                  Text(
                    'Comprar',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w600,
                      color: (bottomBloc.page == 1) ? Color(0xffffb240) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                bottomBloc.changePage(2);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScreenUtil().setHeight(5),
                    backgroundColor: (bottomBloc.page == 2) ? Color(0xffffb240) : Colors.transparent,
                  ),
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    child: (bottomBloc.page == 2)
                        ? SvgPicture.asset(
                            'assets/svg/tabs/user_tab.svg',
                            color: Color(0xffffb240),
                          )
                        : SvgPicture.asset(
                            'assets/svg/tabs/user_tab.svg',
                            color: Color(0xffafafaf),
                          ), //Image.ass//Imagsset('assets/logo_largo.svg'),
                  ),
                  Text(
                    'Cuenta',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w600,
                      color: (bottomBloc.page == 2) ? Color(0xffffb240) : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        //headers: <String, String>{'my_header_key': 'my_headser_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
