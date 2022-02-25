import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/detalle_ticket_database.dart';
import 'package:dicertur_quistococha/database/espacio_database.dart';
import 'package:dicertur_quistococha/database/evento_database.dart';
import 'package:dicertur_quistococha/database/tarifa_database.dart';
import 'package:dicertur_quistococha/database/ticket_database.dart';
import 'package:dicertur_quistococha/src/api/cuenta_api.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/Account/actualizar_foto_perfil.dart';
import 'package:dicertur_quistococha/src/pages/Account/edit_account.dart';
import 'package:dicertur_quistococha/src/pages/politicas_de_privacidad.dart';
import 'package:dicertur_quistococha/src/pages/terminos_y_condiciones.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
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
                        child: CircleAvatar(
                          radius: ScreenUtil().radius(100),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Icon(Icons.error),
                                ),
                              ),
                              imageUrl: '${snapshot.data!.userImage}',
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                    InkWell(
                        onTap: () {
                          _cuenta(context);
                        },
                        child: _itemsConfig('user', 'Cuenta')),
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
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (c) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ), //this right here
                            child: Container(
                              height: ScreenUtil().setHeight(300),
                              width: ScreenUtil().setWidth(400),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(150),
                                          height: ScreenUtil().setHeight(70),
                                          child: Image.asset(
                                            'assets/img/logo_bufeo.png',
                                          ), //Image.asset('assets/logo_largo.svg'),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(16),
                                    ),
                                    Text(
                                      'Cerrar sesión',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFFA8A8A8),
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(16),
                                    ),
                                    Text(
                                      '¿Estas seguro de salir?',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(30),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: ScreenUtil().setWidth(100),
                                          child: MaterialButton(
                                            color: Colors.red,
                                            textColor: Colors.white,
                                            child: Text(
                                              'Si',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(16),
                                              ),
                                            ),
                                            onPressed: () async {
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
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(100),
                                          child: MaterialButton(
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(16),
                                              ),
                                            ),
                                            color: Colors.orange,
                                            textColor: Colors.white,
                                            onPressed: () => Navigator.pop(c),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(10)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: colorPrimary,
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

  void _cuenta(BuildContext context) {
    final dataBloc = ProviderBloc.data(context);
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
                initialChildSize: 0.9,
                minChildSize: 0.3,
                maxChildSize: 0.9,
                builder: (_, controller) {
                  return StreamBuilder(
                      stream: dataBloc.userStream,
                      builder: (context, AsyncSnapshot<UserModel> snapshot) {
                        if (snapshot.hasData) {
                          var user = snapshot.data!;
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: ScreenUtil().setHeight(50),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context, animation, secondaryAnimation) {
                                                      return EditAccount(
                                                        user: user,
                                                      );
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
                                              child: Text(
                                                'Editar',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.blue,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(8),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${user.personName}',
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: ScreenUtil().setSp(20),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(100),
                                        ),
                                        _data(Icons.person, '${user.personName} ${user.personSurname}'),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(12),
                                        ),
                                        _data(Icons.email, '${user.userEmail}'),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(12),
                                        ),
                                        _data(Icons.phone, '${user.telefono}'),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(12),
                                        ),
                                        _data(Icons.cake, '${obtenerFecha(user.nacimiento.toString())}'),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(12),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              _changePassword(context);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.lock,
                                                  color: colorPrimary,
                                                  size: ScreenUtil().setSp(30),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(12),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: colorPrimary,
                                                  size: ScreenUtil().setSp(12),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(6),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: colorPrimary,
                                                  size: ScreenUtil().setSp(12),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(6),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: colorPrimary,
                                                  size: ScreenUtil().setSp(12),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(6),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: colorPrimary,
                                                  size: ScreenUtil().setSp(12),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(6),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: colorPrimary,
                                                  size: ScreenUtil().setSp(12),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(6),
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: colorPrimary,
                                                  size: ScreenUtil().setSp(12),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(12),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.blue,
                                                  size: ScreenUtil().setSp(25),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(50),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(50),
                                        ),
                                        Container(
                                          height: ScreenUtil().setHeight(150),
                                          //width: ScreenUtil().setWidth(200),
                                          child: Image.asset('assets/img/foto perfil.png'),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) {
                                            return ActualizarFotoPerfil();
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
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: ScreenUtil().setWidth(3)),
                                          ),
                                          width: ScreenUtil().setWidth(120),
                                          height: ScreenUtil().setHeight(120),
                                          child: CircleAvatar(
                                            radius: ScreenUtil().radius(100),
                                            child: ClipOval(
                                              child: Image.network(
                                                '${user.userImage}',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 10,
                                          bottom: 1,
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: colorPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Row _data(IconData icon, String data) {
    return Row(
      children: [
        Icon(
          icon,
          color: colorPrimary,
          size: ScreenUtil().setSp(30),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(12),
        ),
        Text(
          '$data',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  void _changePassword(BuildContext context) {
    final _controller = EditController();
    TextEditingController _contraController = TextEditingController();
    TextEditingController _contraConfirmController = TextEditingController();
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
                initialChildSize: 0.8,
                minChildSize: 0.3,
                maxChildSize: 0.9,
                builder: (_, controller) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(24),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(16),
                                ),
                                Center(
                                  child: Container(
                                    width: ScreenUtil().setWidth(100),
                                    height: ScreenUtil().setHeight(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Text(
                                  'Cambiar contraseña',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextField(
                                  controller: _contraController,
                                  obscureText: true,
                                  style: TextStyle(
                                    color: Color(0xff808080),
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.lock_outlined,
                                      color: Colors.blue,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffeeeeee),
                                    labelStyle: TextStyle(
                                      color: Color(0xff808080),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffeeeeee),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffeeeeee),
                                      ),
                                    ),
                                    hintText: 'Nueva contraseña',
                                    hintStyle: TextStyle(
                                      color: Color(0xff808080),
                                    ),
                                    labelText: 'Nueva contraseña',
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(16),
                                ),
                                TextField(
                                  controller: _contraConfirmController,
                                  obscureText: true,
                                  style: TextStyle(
                                    color: Color(0xff808080),
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.lock_outlined,
                                      color: Colors.blue,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffeeeeee),
                                    labelStyle: TextStyle(
                                      color: Color(0xff808080),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffeeeeee),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffeeeeee),
                                      ),
                                    ),
                                    hintText: 'Confirmar contraseña',
                                    hintStyle: TextStyle(
                                      color: Color(0xff808080),
                                    ),
                                    labelText: 'Confirmar contraseña',
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                InkWell(
                                  onTap: () async {
                                    _controller.chnageCargando(true);
                                    if (_contraController.text.isNotEmpty) {
                                      if (_contraConfirmController.text.isNotEmpty) {
                                        if (_contraController.text == _contraConfirmController.text) {
                                          _controller.chnageCargando(true);
                                          final _cuentaApi = CuentaApi();

                                          final res = await _cuentaApi.changePassword(_contraController.text);
                                          if (res.code == '1') {
                                            showToast2('Realizado correctamente', Colors.black);
                                            Navigator.pop(context);
                                          } else {
                                            showToast2(res.message.toString(), Colors.red);
                                          }
                                          _controller.chnageCargando(false);
                                        } else {
                                          showToast2('Contraseñas no coinciden, Por favor inténtalo nuevamente', Colors.red);
                                        }
                                      } else {
                                        showToast2('Debe confirmar la nueva contraseña', Colors.red);
                                      }
                                    } else {
                                      showToast2('Ingresar nueva contraseña', Colors.red);
                                    }
                                    _controller.chnageCargando(false);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 8,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Enviar',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(20),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: _controller,
                          builder: (_, s) {
                            return (_controller.cargando)
                                ? Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.black.withOpacity(0.3),
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  )
                                : Container();
                          }),
                    ],
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