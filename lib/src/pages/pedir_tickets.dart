import 'package:carousel_slider/carousel_slider.dart';
import 'package:dicertur_quistococha/src/api/tarifas_api.dart';
import 'package:dicertur_quistococha/src/models/banner.dart';
import 'package:dicertur_quistococha/src/pages/mostrar_tarifas.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:dicertur_quistococha/src/widget/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PedirTickets extends StatefulWidget {
  const PedirTickets({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<PedirTickets> {
  String fechaDato = 'Selecciona';
  final _controller = TicketsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hola Angelo',
          style: TextStyle(
            color: Color(0xffffb240),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Text(
                'Visita nuestro complejo turistico',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(20),
                  color: Color(0xff505050),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
              Container(
                height: ScreenUtil().setHeight(200),
                child: CarouselSlider.builder(
                  itemCount: bannerList.length,
                  itemBuilder: (context, x, y) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(0),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(bannerList[x].urlImage!),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      height: ScreenUtil().setHeight(552),
                      onPageChanged: (index, page) {},
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayInterval: Duration(seconds: 6),
                      autoPlayAnimationDuration: Duration(milliseconds: 2000),
                      viewportFraction: 0.8),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(48),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(32),
                ),
                child: Row(
                  children: [
                    Text(
                      'FECHA DE VISITA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(20),
                        color: Color(0xff505050),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(32),
                ),
                child: Column(
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(22),
                      child: InkWell(
                        onTap: () {
                          _selectdate(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                fechaDato,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: (fechaDato != 'Seleccionar Todos') ? Color(0xff5a5a5a) : Colors.orange,
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xffffb240),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xffffb240),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
              InkWell(
                onTap: () async {
                  if (fechaDato != 'Selecciona') {
                    _controller.changeLoadding(true);
                    final _tarifaApi = TarifaApi();

                    final res = await _tarifaApi.obtenerTarifas(fechaDato);
                    if (res.code == '1') {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return MostrarTarifas(
                              fecha: fechaDato,
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
                    } else {
                      showToast2('Ocurrió un error, inténtelo nuevamente', Colors.red);
                    }
                    _controller.changeLoadding(false);
                  } else {
                    showToast2('Por favor seleccione una fecha', Colors.red);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffb240),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffffb240).withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 12,
                        offset: Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(25),
                  ),
                  height: ScreenUtil().setHeight(60),
                  child: Row(
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      ),
                      Text(
                        'Continuar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              return ShowLoadding(
                w: double.infinity,
                h: double.infinity,
                colorText: Colors.yellow,
                fondo: Colors.black.withOpacity(0.3),
                active: _controller.loadding,
              );
            },
          ),
        ],
      ),
    );
  }

  _selectdate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().month - 1),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    print('date $picked');

    setState(() {
      fechaDato = "${picked!.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      //inputfieldDateController.text = fechaDato;

      print(fechaDato);
    });
  }
}

class TicketsController extends ChangeNotifier {
  bool loadding = false;
  void changeLoadding(bool v) {
    loadding = v;
    notifyListeners();
  }
}
