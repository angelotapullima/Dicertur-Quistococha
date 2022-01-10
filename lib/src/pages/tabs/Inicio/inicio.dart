import 'package:dicertur_quistococha/src/bloc/data_user.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Cuentos/cuentos.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Servicios/servicios.dart';
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
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'Hola ${snapshot.data!.personName}',
                  style: TextStyle(
                    color: Color(0xffffb240),
                  ),
                ),
              ),
              body: AnimatedBuilder(
                  animation: controller,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
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
                                          fontSize: ScreenUtil().setSp(16),
                                          fontWeight: FontWeight.w500,
                                          color: (controller.valueBoton == 0) ? Color(0xffffb240) : Color(0xff808080),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(2),
                                        ),
                                        height: ScreenUtil().setHeight(2),
                                        width: ScreenUtil().setWidth(40),
                                        color: (controller.valueBoton == 0) ? Color(0xffffb240) : Colors.transparent,
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
                                          fontSize: ScreenUtil().setSp(16),
                                          fontWeight: FontWeight.w500,
                                          color: (controller.valueBoton == 1) ? Color(0xffffb240) : Color(0xff808080),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(2),
                                        ),
                                        height: ScreenUtil().setHeight(2),
                                        width: ScreenUtil().setWidth(70),
                                        color: (controller.valueBoton == 1) ? Color(0xffffb240) : Colors.transparent,
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
                                          fontSize: ScreenUtil().setSp(16),
                                          fontWeight: FontWeight.w500,
                                          color: (controller.valueBoton == 2) ? Color(0xffffb240) : Color(0xff808080),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setHeight(2),
                                        ),
                                        height: ScreenUtil().setHeight(2),
                                        width: ScreenUtil().setWidth(70),
                                        color: (controller.valueBoton == 2) ? Color(0xffffb240) : Colors.transparent,
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
                              ? Container(
                                  child: Text('Inicio'),
                                )
                              : (controller.valueBoton == 1)
                                  ? CuentosPage()
                                  : (
                                     ServiciosPage()
                                    ),
                        )
                      ],
                    );
                  }),
            );
          } else {
            return Container();
          }
        });
  }
}

class ItemController extends ChangeNotifier {
  int valueBoton = 1;

  void changeValueBoton(int v) {
    valueBoton = v;
    notifyListeners();
  }
}
