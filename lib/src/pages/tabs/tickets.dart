import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Tickets extends StatelessWidget {
  const Tickets({Key key}) : super(key: key);
  static final _controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFAFAFA),
      appBar: AppBar(
        title: Text(
          'Mis tickets',
          style: GoogleFonts.poppins(
            color: Color(0XFFFFB240),
            fontWeight: FontWeight.w700,
            //fontSize: ScreenUtil().setSp(18),
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, t) {
              return Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0XFFECF4FF),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _controller.changeValueBoton(1);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(7),
                                horizontal: ScreenUtil().setWidth(2),
                              ),
                              decoration: BoxDecoration(
                                color: (_controller.valueBoton == 1) ? Color(0XFFECF4FF) : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Próximo',
                                  style: GoogleFonts.poppins(
                                    color: (_controller.valueBoton == 1) ? Color(0XFFAFB6DB) : Color(0XFF505050),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _controller.changeValueBoton(2);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(7),
                                horizontal: ScreenUtil().setWidth(2),
                              ),
                              decoration: BoxDecoration(
                                color: (_controller.valueBoton == 2) ? Color(0XFFECF4FF) : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Anteriores',
                                  style: GoogleFonts.poppins(
                                    color: (_controller.valueBoton == 2) ? Color(0XFFAFB6DB) : Color(0XFF505050),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(32),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (_, index) {
                          return _itemTicket(context, (_controller.valueBoton == 1) ? false : true);
                        }),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _itemTicket(BuildContext context, bool esProximo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(24),
                vertical: ScreenUtil().setHeight(16),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(
                children: [
                  (esProximo)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Entrada',
                              style: GoogleFonts.poppins(
                                color: Color(0XFFA8A8A8),
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(14),
                              ),
                            ),
                            Text(
                              '01 agosto',
                              style: GoogleFonts.poppins(
                                color: Color(0XFFA8A8A8),
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(14),
                              ),
                            ),
                            Text(
                              'Salida',
                              style: GoogleFonts.poppins(
                                color: Color(0XFFA8A8A8),
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(14),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            '01 agosto',
                            style: GoogleFonts.poppins(
                              color: Color(0XFFA8A8A8),
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '8:00 AM',
                        style: GoogleFonts.poppins(
                          color: (esProximo) ? Color(0XFF7DBE6D) : Color(0XFF505050),
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                      Text(
                        '2hr',
                        style: GoogleFonts.poppins(
                          color: Color(0XFFA8A8A8),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                      Text(
                        '10:00 AM',
                        style: GoogleFonts.poppins(
                          color: (esProximo) ? Color(0XFFEA5555) : Color(0XFF505050),
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                    width: ScreenUtil().setWidth(10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)), color: Color(0XFFFAFAFA)),
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
                                        decoration: BoxDecoration(color: Color(0XFFC4C4C4)),
                                      ),
                                    )),
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                    width: ScreenUtil().setWidth(10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)), color: Color(0XFFFAFAFA)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(24),
                vertical: ScreenUtil().setHeight(16),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: SvgPicture.asset('assets/svg/visa.svg'),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          Text(
                            '*** 1234',
                            style: GoogleFonts.poppins(
                              color: Color(0XFF505050),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'S/ 45.00',
                        style: GoogleFonts.poppins(
                          color: Color(0XFF505050),
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Método de pago',
                        style: GoogleFonts.poppins(
                          color: Color(0XFFA8A8A8),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                        ),
                      ),
                      Text(
                        'Precio',
                        style: GoogleFonts.poppins(
                          color: Color(0XFFA8A8A8),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Controller extends ChangeNotifier {
  int valueBoton = 1;

  void changeValueBoton(int v) {
    valueBoton = v;
    notifyListeners();
  }
}
