import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:dicertur_quistococha/src/pages/detalle_ticket.dart';
import 'package:dicertur_quistococha/src/pages/tabs/inicio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Tickets extends StatelessWidget {
  const Tickets({Key? key}) : super(key: key);
  static final _controller = Controller();

  @override
  Widget build(BuildContext context) {
    final ticketBloc = ProviderBloc.ticket(context);
    ticketBloc.getTicketsForUser('0');

    return StreamBuilder(
        stream: ticketBloc.ticketStream,
        builder: (context, AsyncSnapshot<List<TicketModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Scaffold(
                backgroundColor: Color(0xFFF3F3F3),
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
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, t) {
                        return Stack(
                          children: [
                            Column(
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

                                            ticketBloc.getTicketsForUser('0');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: ScreenUtil().setHeight(7),
                                              horizontal: ScreenUtil().setWidth(2),
                                            ),
                                            decoration: BoxDecoration(
                                              color: (_controller.valueBoton == 1) ? Colors.white : Color(0XFFECF4FF),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Próximo',
                                                style: GoogleFonts.poppins(
                                                  color: (_controller.valueBoton == 1) ? Color(0XFF505050) : Color(0XFFAFB6DB),
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
                                            ticketBloc.getTicketsForUser('1');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: ScreenUtil().setHeight(7),
                                              horizontal: ScreenUtil().setWidth(2),
                                            ),
                                            decoration: BoxDecoration(
                                              color: (_controller.valueBoton == 2) ? Colors.white : Color(0XFFECF4FF),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Anteriores',
                                                style: GoogleFonts.poppins(
                                                  color: (_controller.valueBoton == 2) ? Color(0XFF505050) : Color(0XFFAFB6DB),
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
                                      padding: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(65),
                                      ),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (_, index) {
                                        return _itemTicket(context, snapshot.data![index]);
                                      }),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: ScreenUtil().setHeight(10),
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return InicioPage();
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
                                  height: ScreenUtil().setSp(45),
                                  width: ScreenUtil().setSp(45),
                                  decoration: BoxDecoration(color: Color(0xffFFB240), borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: Color(0xFFF3F3F3),
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
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, t) {
                        return Stack(
                          children: [
                            Column(
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

                                            ticketBloc.getTicketsForUser('0');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: ScreenUtil().setHeight(7),
                                              horizontal: ScreenUtil().setWidth(2),
                                            ),
                                            decoration: BoxDecoration(
                                              color: (_controller.valueBoton == 1) ? Colors.white : Color(0XFFECF4FF),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Próximo',
                                                style: GoogleFonts.poppins(
                                                  color: (_controller.valueBoton == 1) ? Color(0XFF505050) : Color(0XFFAFB6DB),
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
                                            ticketBloc.getTicketsForUser('1');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: ScreenUtil().setHeight(7),
                                              horizontal: ScreenUtil().setWidth(2),
                                            ),
                                            decoration: BoxDecoration(
                                              color: (_controller.valueBoton == 2) ? Colors.white : Color(0XFFECF4FF),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Anteriores',
                                                style: GoogleFonts.poppins(
                                                  color: (_controller.valueBoton == 2) ? Color(0XFF505050) : Color(0XFFAFB6DB),
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
                               Center(child: Text('No existen tickets disponibles'),)
                              ],
                            ),
                            Positioned(
                              bottom: ScreenUtil().setHeight(10),
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return InicioPage();
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
                                  height: ScreenUtil().setSp(45),
                                  width: ScreenUtil().setSp(45),
                                  decoration: BoxDecoration(color: Color(0xffFFB240), borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
              );
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }

  Widget _itemTicket(BuildContext context, TicketModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(10),
        horizontal: ScreenUtil().setWidth(5),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return DetalleTicketPage(
                  idTicket: model.idTicket,
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
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
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
                    (model.ticketEstado == '0')
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
                                '${model.eventoFecha}',
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
                            color: (model.ticketEstado == '0') ? Color(0XFF7DBE6D) : Color(0XFF505050),
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(18),
                          ),
                        ),
                        Text(
                          'Hasta',
                          style: GoogleFonts.poppins(
                            color: Color(0XFFA8A8A8),
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(18),
                          ),
                        ),
                        Text(
                          '6:00 PM',
                          style: GoogleFonts.poppins(
                            color: (model.ticketEstado == '0') ? Color(0XFFEA5555) : Color(0XFF505050),
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
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final boxWidth = constraints.constrainWidth();
                            final dashWidth = 10.0;
                            final dashCount = (boxWidth / (2 * dashWidth)).floor();

                            return Flex(
                              children: List.generate(dashCount, (_) {
                                return SizedBox(
                                  width: dashWidth,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: Colors.grey),
                                  ),
                                );
                              }),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.grey.withOpacity(0.2),
                        ),
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
                            /*   Container(
                              child: SvgPicture.asset('assets/svg/visa.svg'),
                            ), */
                            SizedBox(
                              width: ScreenUtil().setWidth(8),
                            ),
                            Text(
                              '',
                              style: GoogleFonts.poppins(
                                color: Color(0XFF505050),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'S/${model.ticketTotal}',
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
                          'pago con tarjeta',
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
