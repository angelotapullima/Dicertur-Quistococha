import 'dart:io';
import 'dart:typed_data';

import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';

class DetalleTicketPage extends StatefulWidget {
  final String? idTicket;
  const DetalleTicketPage({Key? key, required this.idTicket}) : super(key: key);

  @override
  _DetalleTicketPageState createState() => _DetalleTicketPageState();
}

class _DetalleTicketPageState extends State<DetalleTicketPage> {
  Uint8List? _imageFile;
  List<String> imagePaths = [];
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final ticketBloc = ProviderBloc.ticket(context);
    ticketBloc.getTicketsForID(widget.idTicket.toString());

    return StreamBuilder(
        stream: ticketBloc.ticketIdStream,
        builder: (context, AsyncSnapshot<List<TicketModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              var fechix = obtenerFecha('${snapshot.data![0].eventoFecha}');
              return Scaffold(
                backgroundColor: Color(0XFFFAFAFA),
                appBar: AppBar(
                  backgroundColor: Color(0XFFFAFAFA),
                  elevation: 0,
                  title: Text(
                    'Ticket: ${snapshot.data![0].ticketCodigoApp}',
                    style: GoogleFonts.poppins(
                      color: Color(0XFF707070),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(14),
                      letterSpacing: 1,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Color(0XFF40A3FF),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
                      child: IconButton(
                        onPressed: () {
                          takeScreenshotandShare();
                        },
                        icon: Icon(Icons.share),
                      ),
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
                    child: Screenshot(
                      controller: screenshotController,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
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
                                          Row(
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
                                              Expanded(
                                                child: Text(
                                                  '$fechix',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: ScreenUtil().setSp(14),
                                                  ),
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
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(12),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${snapshot.data![0].eventoHoraInicio}',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0XFF505050),
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
                                                '${snapshot.data![0].eventoHoraFin}',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0XFF505050),
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
                                                color: Color(0XFFFAFAFA),
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
                                                color: Color(0XFFFAFAFA),
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
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'Complejo Turístico Quistococha',
                                              style: GoogleFonts.poppins(
                                                color: Color(0XFF505050),
                                                fontWeight: FontWeight.w500,
                                                fontSize: ScreenUtil().setSp(16),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(9),
                                          ),
                                          Center(
                                            child: Text(
                                              'Km. 4.5 Carrt. Iquitos-Nauta',
                                              style: GoogleFonts.poppins(
                                                color: Color(0XFFA8A8A8),
                                                fontWeight: FontWeight.w400,
                                                fontSize: ScreenUtil().setSp(14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(24),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Cliente',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0XFFA8A8A8),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: ScreenUtil().setSp(14),
                                                ),
                                              ),
                                              Text(
                                                'DNI',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0XFFA8A8A8),
                                                  fontWeight: FontWeight.w400,
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
                                              Expanded(
                                                child: Text(
                                                  '${snapshot.data![0].clienteNombre}',
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0XFF505050),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ScreenUtil().setSp(16),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setWidth(10),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(85),
                                                child: Text(
                                                  '${snapshot.data![0].clienteDni}',
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0XFF505050),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ScreenUtil().setSp(16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
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
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(24),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Tipo',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0XFFA8A8A8),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: ScreenUtil().setSp(14),
                                                ),
                                              ),
                                              Text(
                                                'Cantidad',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0XFFA8A8A8),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: ScreenUtil().setSp(14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(12),
                                          ),
                                          (snapshot.data![0].detalle!.length > 0)
                                              ? Container(
                                                  height: (snapshot.data![0].detalle!.length + 1) * ScreenUtil().setHeight(25),
                                                  child: ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: snapshot.data![0].detalle!.length,
                                                      itemBuilder: (context, index2) {
                                                        return Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                '${snapshot.data![0].detalle![index2].tarifaNombre}',
                                                                style: GoogleFonts.poppins(
                                                                  color: Color(0XFF505050),
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: ScreenUtil().setSp(16),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: ScreenUtil().setWidth(70),
                                                              child: Text(
                                                                '${snapshot.data![0].detalle![index2].tarifaDetalleCantidad} X ${snapshot.data![0].detalle![index2].tarifaPrecio}',
                                                                style: GoogleFonts.poppins(
                                                                  color: Color(0XFF505050),
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: ScreenUtil().setSp(16),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
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
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(24),
                                        vertical: ScreenUtil().setHeight(11),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.only(
                                        //   bottomLeft: Radius.circular(15),
                                        //   bottomRight: Radius.circular(15),
                                        // ),
                                      ),
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
                                              ('${snapshot.data![0].ticketTipoPago}' == '1')
                                                  ? Text(
                                                      'Pago con tarjeta',
                                                      style: GoogleFonts.poppins(
                                                        color: Color(0XFF505050),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: ScreenUtil().setSp(16),
                                                      ),
                                                    )
                                                  : Text(
                                                      'Pago en efectivo',
                                                      style: GoogleFonts.poppins(
                                                        color: Color(0XFF505050),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: ScreenUtil().setSp(16),
                                                      ),
                                                    ),
                                              Spacer(),
                                              Text(
                                                'S/.${snapshot.data![0].ticketTotal}',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0XFF505050),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: ScreenUtil().setSp(18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
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
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(24),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Al momento de ingresar al complejo por favor dejar que escaneen su ticket',
                                              style: GoogleFonts.poppins(
                                                color: Color(0XFFA8A8A8),
                                                fontWeight: FontWeight.w500,
                                                fontSize: ScreenUtil().setSp(14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(20)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: ScreenUtil().setWidth(250),
                                          width: ScreenUtil().setWidth(250),
                                          child: PrettyQr(
                                            data:
                                                '${snapshot.data![0].rucQR}|${snapshot.data![0].ventaTipoQR}|${snapshot.data![0].ventaSerieQR}|${snapshot.data![0].ventaCorrelativoQR}|${snapshot.data![0].ventaTotalIGVQR}|${snapshot.data![0].ventaTotalQR}|${snapshot.data![0].ventaFechaQR}|${snapshot.data![0].clienteTipoDocumetoCodigoQR}|${snapshot.data![0].clienteNumeroQR}|${snapshot.data![0].idTicket}',
                                            size: ScreenUtil().setSp(80),
                                            image: AssetImage('assets/img/1000x1000.png'),
                                            errorCorrectLevel: QrErrorCorrectLevel.Q,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(52),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          (snapshot.data![0].ticketEstado == '2')
                              ? Container(
                                  child: SvgPicture.asset('assets/svg/utilizado.svg'),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return StreamBuilder(
                  stream: ticketBloc.cargando,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return (snapshot.data!)
                          ? Scaffold(
                              body: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            )
                          : Container();
                    } else {
                      return Container();
                    }
                  });
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }

  takeScreenshotandShare() async {
    var now = DateTime.now();
    var nombre = now.microsecond.toString();
    _imageFile = null;
    screenshotController.capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0).then((Uint8List? image) async {
      setState(() {
        _imageFile = image;
      });

      await ImageGallerySaver.saveImage(image!);

      // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver
      print("File Saved to Gallery");

      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List? pngBytes = _imageFile;
      File imgFile = new File('$directory/Screenshot$nombre.png');
      imgFile.writeAsBytes(pngBytes!);
      print("File Saved to Gallery");

      imagePaths.clear();
      imagePaths.add(imgFile.path);
      if (imagePaths.isNotEmpty) {
        await Future.delayed(
          Duration(seconds: 1),
        );

        ShareExtend.shareMultiple(imagePaths, "image", subject: "goleadores");
      } else {
        //showToast2('Ocurrio un error', Colors.yellow);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
