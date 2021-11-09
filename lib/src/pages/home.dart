import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/tabs/account.dart';
import 'package:dicertur_quistococha/src/pages/tabs/inicio.dart';
import 'package:dicertur_quistococha/src/pages/tabs/tickets.dart';
import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(InicioPage());
    pageList.add(Tickets());
    pageList.add(Account());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomBloc = ProviderBloc.bottom(context);

    final responsive = Responsive.of(context);

    return Scaffold(
      body: StreamBuilder(
        stream: bottomBloc.selectPageStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: kBottomNavigationBarHeight + responsive.hp(4),
                  ),
                  child: IndexedStack(
                    index: bottomBloc.page,
                    children: pageList,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: responsive.wp(3),
                      right: responsive.wp(3),
                      bottom: responsive.hp(1.5),
                    ),
                    height: kBottomNavigationBarHeight + responsive.hp(4),
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
                              Container(
                                height: responsive.ip(4),
                                width: responsive.ip(4),
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
                              CircleAvatar(
                                radius: ScreenUtil().setHeight(5),
                                backgroundColor: (bottomBloc.page == 0) ? Color(0xffffb240) : Colors.transparent,
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
                              Container(
                                height: responsive.ip(4),
                                width: responsive.ip(4),
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
                              CircleAvatar(
                                radius: ScreenUtil().setHeight(5),
                                backgroundColor: (bottomBloc.page == 1) ? Color(0xffffb240) : Colors.transparent,
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
                              Container(
                                height: responsive.ip(4),
                                width: responsive.ip(4),
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
                              CircleAvatar(
                                radius: ScreenUtil().setHeight(5),
                                backgroundColor: (bottomBloc.page == 2) ? Color(0xffffb240) : Colors.transparent,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
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
}
