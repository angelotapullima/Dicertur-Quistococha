

import 'package:dicertur_quistococha/src/pages/old/detalle_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MetodoPago extends StatelessWidget {
  const MetodoPago({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'MÉTODO DE PAGO',
          style: TextStyle(
            color: Color(0xff808080),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
            ),
            width: double.infinity,
            height: ScreenUtil().setHeight(250),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.8],
                colors: [
                  Color(0xff00afef),
                  Color(0xff0077bd),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff323232).withOpacity(0.25),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(30),
                      child: SvgPicture.asset(
                        'assets/svg/visa_white.svg',
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: Container(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setHeight(50),
                        child: Image(
                          image: AssetImage('assets/svg/gore2.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(80),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(2),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(2),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(2),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(2),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(2),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(2),
                      ),
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(8),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      ),
                      Text(
                        '1234',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(
                            22,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  child: Row(
                    children: [
                      Text(
                        'Bufeotec Company',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(
                            18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        '11/25',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(
                            18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                )
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Row(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(20),
              ),
              Text(
                'Detalles',
                style: TextStyle(
                  color: Color(0xff505050),
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(
                    22,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
            ),
            height: ScreenUtil().setHeight(125),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff323232).withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Container(
                      height: ScreenUtil().setSp(40),
                      width: ScreenUtil().setSp(40),
                      child: Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: ScreenUtil().setHeight(15),
                              backgroundColor: Colors.green,
                            ),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: ScreenUtil().setHeight(12),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: ScreenUtil().setHeight(9),
                              backgroundColor: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Flex(
                              children: List.generate(
                                (constraints.constrainWidth() / 10).floor(),
                                (index) => SizedBox(
                                  height: ScreenUtil().setHeight(1),
                                  width: ScreenUtil().setWidth(5),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Color(0XFFC4C4C4),
                                    ),
                                  ),
                                ),
                              ),
                              direction: Axis.horizontal,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setSp(80),
                      width: ScreenUtil().setSp(40),
                      child: Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: ScreenUtil().setHeight(15),
                              backgroundColor: Color(0xffffb240),
                            ),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: ScreenUtil().setHeight(12),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: ScreenUtil().setHeight(9),
                              backgroundColor: Color(0xffffb240),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Salida'),
                        Text(
                          '08:00 AM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '2hr',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(25),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Salida'),
                        Text(
                          '08:00 AM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(10)),
            height: ScreenUtil().setHeight(150),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff323232).withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Nombre',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                    Text('BufeoTec Company'),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      'Dni',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                    Text('11111111'),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      'Entradas',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                    Text('4'),
                  ],
                ),
                Divider()
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetalleTicketPage(
                      esProximo: true,
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
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8A62C),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF8A62C).withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 12,
                    offset: Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
              ),
              height: ScreenUtil().setHeight(60),
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(20),
                  ),
                  Text(
                    'Confirmar Pago',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(20),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'S/45.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(20),
                    ),
                  ),
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
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
        ],
      ),
    );
  }
}
