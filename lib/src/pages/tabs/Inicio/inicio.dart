import 'package:dicertur_quistococha/src/bloc/data_user.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Cuentos/cuentos.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Foro/foro.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Galeria/galeria.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Servicios/servicios.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/widget/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  String fechaDato = 'Selecciona';

  final controller = ItemController();

  @override
  Widget build(BuildContext context) {
    final dataBloc = ProviderBloc.data(context);
    dataBloc.obtenerUser();

    return StreamBuilder(
        stream: dataBloc.userStream,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            var dato = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.white,
              body: AnimatedBuilder(
                animation: controller,
                builder: (context, snapshot) {
                  return SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                            vertical: ScreenUtil().setHeight(5),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                height: ScreenUtil().setSp(50),
                                child: Image.asset('assets/img/1000x1000.png'),
                              ),
                              Expanded(
                                child: Text(
                                  'Hola ${dato!.personName}',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(18),
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                              CartWidget()
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Divider(
                            thickness: .1,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: ScreenUtil().setWidth(20),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.changeValueBoton(0);
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Inicio',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w600,
                                          color: (controller.valueBoton == 0) ? colorPrimary : Color(0xff808080),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(2),
                                        ),
                                        height: ScreenUtil().setHeight(2),
                                        width: ScreenUtil().setWidth(40),
                                        color: (controller.valueBoton == 0) ? colorPrimary : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.changeValueBoton(1);
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Cuentos',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w600,
                                          color: (controller.valueBoton == 1) ? colorPrimary : Color(0xff808080),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(2),
                                        ),
                                        height: ScreenUtil().setHeight(2),
                                        width: ScreenUtil().setWidth(70),
                                        color: (controller.valueBoton == 1) ? colorPrimary : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.changeValueBoton(2);
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Servicios',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w600,
                                          color: (controller.valueBoton == 2) ? colorPrimary : Color(0xff808080),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(2),
                                        ),
                                        height: ScreenUtil().setHeight(2),
                                        width: ScreenUtil().setWidth(70),
                                        color: (controller.valueBoton == 2) ? colorPrimary : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.changeValueBoton(3);
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Galería',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w600,
                                          color: (controller.valueBoton == 3) ? colorPrimary : Color(0xff808080),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(2),
                                        ),
                                        height: ScreenUtil().setHeight(2),
                                        width: ScreenUtil().setWidth(70),
                                        color: (controller.valueBoton == 3) ? colorPrimary : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: .1,
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(20),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: (controller.valueBoton == 0)
                              ? ForoPage()
                              : (controller.valueBoton == 1)
                                  ? CuentosPage()
                                  : (controller.valueBoton == 2)
                                      ? ServiciosPage()
                                      : GaleriaPage(),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class ItemController extends ChangeNotifier {
  int valueBoton = 0;

  void changeValueBoton(int v) {
    valueBoton = v;
    notifyListeners();
  }
}
