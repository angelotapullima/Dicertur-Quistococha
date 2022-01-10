import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/detalle_ticket_database.dart';
import 'package:dicertur_quistococha/database/espacio_database.dart';
import 'package:dicertur_quistococha/database/evento_database.dart';
import 'package:dicertur_quistococha/database/tarifa_database.dart';
import 'package:dicertur_quistococha/database/ticket_database.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/politicas_de_privacidad.dart';
import 'package:dicertur_quistococha/src/pages/terminos_y_condiciones.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dicertur_quistococha/src/bloc/data_user.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataBloc = ProviderBloc.data(context);
    dataBloc.obtenerUser();

    return StreamBuilder(
        stream: dataBloc.userStream,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Color(0XFF3A3A3A),
                ),
                title: Text(
                  'Cuenta',
                  style: GoogleFonts.poppins(
                    color: Color(0XFF3A3A3A),
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.16,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Center(
                      child: Container(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setHeight(100),
                        child: Image.asset('assets/svg/profile.png'),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Center(
                      child: Text(
                        '${snapshot.data!.personName} ${snapshot.data!.personSurname}',
                        style: GoogleFonts.poppins(
                          color: Color(0XFF3A3A3A),
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    InkWell(onTap: () {}, child: _itemsConfig('user', 'Cuenta')),
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return TerminosYCondiciones();
                              },
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                var begin = Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end).chain(
                                  CurveTween(curve: curve),
                                );

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                          //TerminosYCondiciones
                        },
                        child: _itemsConfig('file', 'Términos de uso')),
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return PoliticasPrivacidad();
                              },
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                var begin = Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end).chain(
                                  CurveTween(curve: curve),
                                );

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: _itemsConfig('policies', 'Políticas de privacidad')),
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    _itemsConfig('help', 'Ayuda'),
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    InkWell(
                      onTap: () {
                        _versionInfo(context, '1.0.0');
                      },
                      child: _itemsConfig('version', 'v.1.0.0'),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(46),
                    ),
                    InkWell(
                      onTap: () async {
                        final detalleTicketDatabase = DetalleTicketDatabase();
                        final espacioDatabase = EspacioDatabase();
                        final eventoDatabase = EventoDatabase();
                        final tarifaDatabase = TarifaDatabase();
                        final ticketDatabase = TicketDatabase();

                        await StorageManager.deleteAllData();

                        await detalleTicketDatabase.deleteDetalleTicket();
                        await espacioDatabase.deleteEspacio();
                        await eventoDatabase.deleteEvento();
                        await tarifaDatabase.deleteTarifas();
                        await ticketDatabase.deleteTicket();

                        StorageManager.saveData('versionApp', '$versionApp2');

                        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(10)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color(0xffffb240),
                        ),
                        child: Text(
                          'Cerrar sesión',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  void _versionInfo(BuildContext context, String version) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.3,
                maxChildSize: 0.3,
                builder: (_, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(16),
                          ),
                          Text(
                            'Desarrollado por:',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(8),
                          ),
                          Container(
                            height: ScreenUtil().setHeight(100),
                            width: ScreenUtil().setWidth(200),
                            child: Image.asset('assets/img/logo_bufeo.png'),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(16),
                          ),
                          Text(
                            'Versión $version',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _itemsConfig(String icon, String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
      child: Row(
        children: [
          Container(
            height: ScreenUtil().setHeight(24),
            width: ScreenUtil().setWidth(24),
            child: SvgPicture.asset('assets/settings_svg/$icon.svg'),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(16),
          ),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0XFF585858),
            size: ScreenUtil().setHeight(16),
          )
        ],
      ),
    );
  }
}
 


 //https://bufeotec.com/tickets/Login/politicas
 //https://bufeotec.com/tickets/Login/terminos