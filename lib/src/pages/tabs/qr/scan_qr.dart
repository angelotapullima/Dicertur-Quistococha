import 'dart:io';

import 'package:dicertur_quistococha/src/pages/cobro_ticket.dart';
import 'package:dicertur_quistococha/src/pages/tabs/qr/bloc_contador_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcodeData;
  QRViewController? controller;

  @override
  void didChangeDependencies() {
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
    final provider = Provider.of<ContadorQrBloc>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          qrView(context, provider),
          Positioned(
            bottom: 10,
            right: 1,
            left: 1,
            child: Center(child: resultadoScanQR()),
          )
        ],
      ),
    );
  }

  Widget resultadoScanQR() {
    return Text(
      barcodeData != null ? 'Resultado: ${barcodeData!.code}' : 'Escanear QR',
      style: TextStyle(color: Colors.white),
      maxLines: 3,
      textAlign: TextAlign.center,
    );
  }

  Widget qrView(BuildContext context, ContadorQrBloc contador) {
    return QRView(
      key: qrKey,
      onQRViewCreated: (valoor) {
        return onQRViewCreated2(valoor, contador);
      },
      overlay: QrScannerOverlayShape(
        borderWidth: ScreenUtil().setWidth(15),
        borderRadius: 10,
        borderLength: 40,
        borderColor: Colors.orange,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void onQRViewCreated2(QRViewController controller, ContadorQrBloc contador) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      if (contador.valor.value == 0) {
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
        contador.changeValorQr(1);
      }
      setState(() {
        this.barcodeData = barcode;
      });
    });
  }
}
