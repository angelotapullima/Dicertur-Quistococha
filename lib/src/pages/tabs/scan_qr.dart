import 'dart:io';

import 'package:dicertur_quistococha/src/pages/cobro_ticket.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  int con = 0;
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcodeData;
  QRViewController? controller;


@override
  void didChangeDependencies() {
    showToast2('bienvenido',Colors.red);
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('init');
    con = 0;
    super.initState();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          qrView(context),
          Positioned(
            bottom: 10,
            child: resultadoScanQR(),
          )
        ],
      ),
    );
  }

  Widget resultadoScanQR() {
    return Text(
      barcodeData != null ? 'Resultado: ${barcodeData!.code}' : 'Scanear QR',
      style: TextStyle(color: Colors.white),
      maxLines: 3,
      textAlign: TextAlign.center,
    );
  }

  Widget qrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderWidth: ScreenUtil().setWidth(15),
        borderRadius: 10,
        borderLength: 40,
        borderColor: Colors.orange,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      if (con == 0 ) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return CobroTicket(
                idTicket: barcode.code.toString(),
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
        con++;
      }
      setState(() {
        this.barcodeData = barcode;
      });
    });
  }
}
