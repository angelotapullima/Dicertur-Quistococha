import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgregarCompany extends StatefulWidget {
  const AgregarCompany({Key key}) : super(key: key);

  @override
  _AgregarCompanyState createState() => _AgregarCompanyState();
}

class _AgregarCompanyState extends State<AgregarCompany> {
  void llamado() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  Text(
                    'AGREGAR ACOMPAÑANTE',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(22),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Row(
                children: [
                  Text(
                    'Adultos',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CantidadTab(
                    llamada: this.llamado,
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Adultos mayores',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CantidadTab(
                    llamada: this.llamado,
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Niños',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CantidadTab(
                    llamada: this.llamado,
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Extranjeros',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CantidadTab(
                    llamada: this.llamado,
                  )
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'SeleccionaHorario');
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
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CantidadTab extends StatefulWidget {
  final Function llamada;

  CantidadTab({Key key, @required this.llamada}) : super(key: key);

  @override
  _CantidadTabState createState() => _CantidadTabState();
}

class _CantidadTabState extends State<CantidadTab> {
  int _counter = 0;

  void _increase() {
    setState(() {
      _counter++;
      widget.llamada();
    });
  }

  void _decrease() {
    setState(() {
      _counter--;
      widget.llamada();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);

    return _cantidad(responsive);
  }

  Widget _cantidad(
    Responsive responsive,
  ) {
    final pad = responsive.hp(1);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: pad),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        width: responsive.wp(40),
        height: responsive.hp(7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  if (_counter != 0) {
                    _decrease();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xffffb240), borderRadius: BorderRadius.circular(100)),
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      "-",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.ip(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.white,
                height: double.infinity,
                child: Center(
                  child: Text(
                    _counter.toString(),
                    style: TextStyle(
                      color: Color(0xff505050),
                      fontSize: responsive.ip(3.5),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  _increase();
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xffffb240), borderRadius: BorderRadius.circular(100)),
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.ip(3.6),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
