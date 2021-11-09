import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:dicertur_quistococha/src/utils/sliver_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeleccionaHorario extends StatefulWidget {
  const SeleccionaHorario({Key key}) : super(key: key);

  @override
  _SeleccionaHorarioState createState() => _SeleccionaHorarioState();
}

class _SeleccionaHorarioState extends State<SeleccionaHorario> {
  String today;
  String fechaqueLlega;

  @override
  void initState() {
    today = toDateMonthYear(DateTime.now()).toString();
    final fechaFormat = today.split(" ");
    fechaqueLlega = fechaFormat[0].trim();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(70)),
              child: CustomScrollView(
                slivers: [
                  HeaderpersistentDCanchas(fechaActual: fechaqueLlega),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 20,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(10),
                                  horizontal: ScreenUtil().setWidth(20),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xff202020).withOpacity(.5),
                                  ),
                                ),
                                height: ScreenUtil().setHeight(90),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Entrada'),
                                        Text(
                                          '08:00 AM',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '4',
                                          style: TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(25), fontWeight: FontWeight.bold),
                                        ),
                                        Text('espacios'),
                                        Text('disponibles'),
                                      ],
                                    ),
                                    Container(
                                      height: ScreenUtil().setSp(80),
                                      width: ScreenUtil().setSp(40),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: CircleAvatar(
                                              radius: ScreenUtil().setHeight(15),
                                              backgroundColor: (index == 0) ? Color(0xffffb240) : Color(0xff909090),
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
                                              backgroundColor: (index == 0) ? Color(0xffffb240) : Color(0xff909090),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'MetodoPago');
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
          ),
        ],
      ),
    );
  }
}

class HeaderpersistentDCanchas extends StatefulWidget {
  const HeaderpersistentDCanchas({
    Key key,
    @required this.fechaActual,
  }) : super(key: key);

  final String fechaActual;

  @override
  _HeaderpersistentDCanchasState createState() => _HeaderpersistentDCanchasState();
}

class _HeaderpersistentDCanchasState extends State<HeaderpersistentDCanchas> {
  DatePickerController _controller = DatePickerController();
  String fechaBusqueda;
  String diaDeLaSemana;
  String idDeLaCancha;
  String fechaqueLlega;
  DateTime today;
  int dias;

  DateTime initialData;

  @override
  void initState() {
    today = toDateMonthYear(DateTime.now());

    initialData = today;
    dias = 30;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    //canchasBloc.obtenerSaldo();

    return SliverPersistentHeader(
      floating: true,
      delegate: SliverCustomHeaderDelegate(
        maxHeight: responsive.hp(22),
        minHeight: responsive.hp(22),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  BackButton(),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(2),
                ),
                child: DatePicker(
                  initialData,
                  height: responsive.hp(13),
                  width: responsive.wp(15),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Color(0xffffb240),
                  locale: 'es_Es',
                  controller: _controller,
                  dateTextStyle: TextStyle(
                    fontSize: responsive.ip(2.6),
                  ),
                  monthTextStyle: TextStyle(
                    fontSize: responsive.ip(1.4),
                  ),
                  dayTextStyle: TextStyle(
                    fontSize: responsive.ip(1.2),
                  ),
                  daysCount: dias,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    print(date);
                    fechaBusqueda = date.toString();
                    diaDeLaSemana = date.weekday.toString();

                    final fechaFormat = fechaBusqueda.split(" ");
                    fechaqueLlega = fechaFormat[0].trim();

                    _controller.animateToDate(date);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DateTime> getDateList(DateTime firstDate, DateTime lastDate) {
  List<DateTime> list = [];
  int count = daysCount(toDateMonthYear(firstDate), toDateMonthYear(lastDate));
  for (int i = 0; i < count; i++) {
    list.add(toDateMonthYear(firstDate).add(Duration(days: i)));
  }
  return list;
}

DateTime toDateMonthYear(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

int daysCount(DateTime first, DateTime last) => last.difference(first).inDays + 1;

enum LabelType {
  date,
  month,
  weekday,
}
