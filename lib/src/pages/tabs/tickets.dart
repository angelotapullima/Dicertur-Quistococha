import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/ticket_bloc.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:dicertur_quistococha/src/pages/compra_tickets.dart';
import 'package:dicertur_quistococha/src/pages/detalle_ticket.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/widget/cart_widget.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(bottom: false,
        child: StreamBuilder(
          stream: ticketBloc.ticketStream,
          builder: (context, AsyncSnapshot<List<TicketModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, t) {
                    return Stack(
                      children: [
                        Column(
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
                                    'Mis tickets',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(18),
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                              CartWidget()],
                          ),
                        ),
                       
                              
                           
                            banner(),
                            tabAnimated(ticketBloc),
                            SizedBox(
                              height: ScreenUtil().setHeight(32),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(20),
                                  bottom: ScreenUtil().setHeight(65),
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) {
                                  return _itemTicket(context, snapshot.data![index]);
                                },
                              ),
                            ),
                          ],
                        ),
                        ticketsAdd(context)
                      ],
                    );
                  },
                );
              } else {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, t) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                             SafeArea(
                               child: Container(
                                 padding:EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                                 child: Text(
                                    'Mis tickets',
                                    style: GoogleFonts.poppins(
                                      color: colorPrimary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(19),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                               ),
                             ),
                           
                            banner(),
                            tabAnimated(ticketBloc),
                            SizedBox(
                              height: ScreenUtil().setHeight(32),
                            ),
                            StreamBuilder(
                              stream: ticketBloc.cargando,
                              builder: (context, AsyncSnapshot<bool> snapshot) {
                                if (snapshot.hasData) {
                                  return (snapshot.data!)
                                      ? Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : Container(
                                          child: Center(
                                            child: Text('No tiene tickets '),
                                          ),
                                        );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                        ticketsAdd(context)
                      ],
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget ticketsAdd(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil().setHeight(10),
      right: 10,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return CompraTicketPage();
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
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(5),
            vertical: ScreenUtil().setHeight(5),
          ),
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                'Comprar Tickets  ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(Icons.add, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Container tabAnimated(TicketBloc ticketBloc) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
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
                  color: (_controller.valueBoton == 1) ? colorPrimary : Color(0XFFECF4FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Vigentes',
                    style: GoogleFonts.poppins(
                      color: (_controller.valueBoton == 1) ? Colors.white : Color(0XFFAFB6DB),
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
                ticketBloc.getTicketsForUser('2');
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(7),
                  horizontal: ScreenUtil().setWidth(2),
                ),
                decoration: BoxDecoration(
                  color: (_controller.valueBoton == 2) ? colorPrimary : Color(0XFFECF4FF),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Usados',
                    style: GoogleFonts.poppins(
                      color: (_controller.valueBoton == 2) ? Colors.white : Color(0XFFAFB6DB),
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
    );
  }

  Widget banner() {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(5),
      ),
      color: Colors.red,
      height: ScreenUtil().setHeight(100),
      width: double.infinity,
      child: Image.asset('assets/img/quistococha_2.jpg', fit: BoxFit.fitWidth),
    );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Código :',
                          style: GoogleFonts.poppins(
                            color: Color(0XFFA8A8A8),
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${model.ticketCodigoApp}- ${model.idTicket}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                      ],
                    ),
                    (model.ticketEstado == '0' || model.ticketEstado == '1')
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
                                  color: Color(0xffA8A8A8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(14),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                'Fecha:  ',
                                style: GoogleFonts.poppins(
                                  color: Color(0xffA8A8A8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(14),
                                ),
                              ),
                              Text(
                                ' ${model.eventoFecha}',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(14),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.eventoHoraInicio}',
                          style: GoogleFonts.poppins(
                            color: (model.ticketEstado == '0' || model.ticketEstado == '1') ? Color(0xff7DBE6D) : Color(0xff505050),
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
                          '${model.eventoHoraFin}',
                          style: GoogleFonts.poppins(
                            color: (model.ticketEstado == '0' || model.ticketEstado == '1') ? Color(0xffEA5555) : Color(0xff505050),
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
                        Text(
                          'Método de pago',
                          style: GoogleFonts.poppins(
                            color: Color(0XFFA8A8A8),
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                        Spacer(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'pago con tarjeta',
                          style: GoogleFonts.poppins(
                            color: Color(0xff505050),
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                        Text(
                          'S/${model.ticketTotal}',
                          style: GoogleFonts.poppins(
                            color: Color(0xff505050),
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Row(
                      children: [
                        ('${model.ticketEstado}' == '0')
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(5),
                                  vertical: ScreenUtil().setHeight(1),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Boleto sin usar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ('${model.ticketEstado}' == '1')
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(5),
                                      vertical: ScreenUtil().setHeight(1),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[800],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Boleto parcialmente usado',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(5),
                                      vertical: ScreenUtil().setHeight(1),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'Boleto completamente usado',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                      ],
                    )
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
