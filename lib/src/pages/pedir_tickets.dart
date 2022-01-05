import 'package:carousel_slider/carousel_slider.dart';
import 'package:dicertur_quistococha/src/models/banner.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

class PedirTickets extends StatefulWidget {
  const PedirTickets({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<PedirTickets> {
  String fechaDato = 'Selecciona';

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
      body: Column(
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
            onTap: () {
              if (fechaDato != 'Selecciona') {
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
    );
  }

  _selectdate(BuildContext context) async {
    DateTime? picked = await PlatformDatePicker.showDate(
      context: context,
      backgroundColor: Colors.white,
      firstDate: DateTime.now(),
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
