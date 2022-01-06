import 'package:dicertur_quistococha/src/api/tickets_api.dart';
import 'package:dicertur_quistococha/src/models/evento_model.dart';
import 'package:dicertur_quistococha/src/models/tarifas_monto_precio_model.dart';
import 'package:dicertur_quistococha/src/pages/old/detalle_ticket.dart';
import 'package:dicertur_quistococha/src/pages/pedir_tickets.dart';
import 'package:dicertur_quistococha/src/pages/web_view_pago_tickets.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:dicertur_quistococha/src/widget/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidarDatosPrepago extends StatefulWidget {
  const ValidarDatosPrepago({Key? key, required this.evento, required this.tarifas, required this.total, required this.totalEntradas})
      : super(key: key);
  final EventoModel evento;
  final List<TarifasMontoPrecioModel> tarifas;
  final String total;
  final String totalEntradas;

  @override
  State<ValidarDatosPrepago> createState() => _ValidarDatosPrepagoState();
}

class _ValidarDatosPrepagoState extends State<ValidarDatosPrepago> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _telController = TextEditingController();

  final _controller = TicketsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'CONFIRMAR PAGO',
          style: GoogleFonts.poppins(
            color: Color(0xff808080),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + ScreenUtil().setHeight(20)),
              child: Column(
                children: [
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
                                Text('Fecha'),
                                Text(
                                  '${widget.evento.eventoFecha}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Hora'),
                                Text(
                                  '${widget.evento.eventoHora}',
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
                              'Tarifa',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Spacer(),
                            Text('Cantidad'),
                          ],
                        ),
                        Divider(),
                        ListView.builder(
                          itemCount: widget.tarifas.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
                              child: Row(
                                children: [
                                  Text(
                                    '${widget.tarifas[index].tarifaNombre}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Text('X ${widget.tarifas[index].tarifaCantidad}'),
                                ],
                              ),
                            );
                          },
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Spacer(),
                            Text('${widget.totalEntradas}'),
                          ],
                        ),
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
                            Expanded(
                              child: Container(
                                height: ScreenUtil().setHeight(35),
                                child: TextField(
                                  controller: _nombreController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(4),
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                      size: ScreenUtil().setHeight(18),
                                    ),
                                    hintText: 'Nombre',
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                        fontStyle: FontStyle.normal),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: ScreenUtil().setHeight(35),
                                child: TextField(
                                  controller: _dniController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  maxLength: 8,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(4),
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                      size: ScreenUtil().setHeight(18),
                                    ),
                                    hintText: 'DNI',
                                    counterText: '',
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                        fontStyle: FontStyle.normal),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: ScreenUtil().setHeight(35),
                                child: TextField(
                                  controller: _telController,
                                  maxLines: 1,
                                  maxLength: 9,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(4),
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                      size: ScreenUtil().setHeight(18),
                                    ),
                                    hintText: 'Teléfono',
                                    counterText: '',
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                        fontStyle: FontStyle.normal),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(100),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () async {
                _controller.changeLoadding(true);
                if (_nombreController.text.isNotEmpty) {
                  if (_dniController.text.isNotEmpty) {
                    if (_telController.text.isNotEmpty) {
                      final _ticketApi = TicketsApi();
                      String detalle = '';
                      for (var i = 0; i < widget.tarifas.length; i++) {
                        detalle += '${widget.tarifas[i].idTarifa},,,${widget.tarifas[i].tarifaCantidad}//--';
                      }

                      final res = await _ticketApi.guardarTicket(
                          widget.evento.idEvento.toString(), widget.total, detalle, _nombreController.text, _telController.text, _dniController.text);

                      if (res.code == '1') {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return WebViewPagosTickets(
                                link: res.url.toString(),
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
                        showToast2(res.message.toString(), Colors.black);
                      }
                    } else {
                      showToast2('Ingrese teléfono', Colors.black);
                    }
                  } else {
                    showToast2('Ingrese DNI', Colors.black);
                  }
                } else {
                  showToast2('Ingrese nombre', Colors.black);
                }
                _controller.changeLoadding(false);
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
                  vertical: ScreenUtil().setHeight(20),
                ),
                height: kBottomNavigationBarHeight + ScreenUtil().setHeight(5),
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
                      'S/ ${widget.total}',
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
}
