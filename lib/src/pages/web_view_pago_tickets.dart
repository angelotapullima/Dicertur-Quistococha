import 'dart:async';

import 'package:dicertur_quistococha/src/bloc/nuevo_metodo_pago_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/pages/detalle_ticket.dart';
import 'package:dicertur_quistococha/src/pages/detalle_ticket_pagoOnline.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPagosTickets extends StatefulWidget {
  final String link;
  final String idTicket;
  const WebViewPagosTickets({
    Key? key,
    required this.link,
    required this.idTicket,
  }) : super(key: key);
  @override
  _WebViewPagosTicketsState createState() => _WebViewPagosTicketsState();
}

class _WebViewPagosTicketsState extends State<WebViewPagosTickets> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (c) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ), //this right here
          child: Container(
            height: ScreenUtil().setHeight(300),
            width: ScreenUtil().setWidth(400),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(150),
                        height: ScreenUtil().setHeight(70),
                        child: Image.asset(
                          'assets/img/logo.png',
                        ), //Image.asset('assets/logo_largo.svg'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Text(
                    'El pago está en proceso',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFA8A8A8),
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Text(
                    '¿Estas seguro de salir?',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: ScreenUtil().setWidth(100),
                        child: MaterialButton(
                          color: Color(0XFF40A3FF),
                          textColor: Colors.white,
                          child: Text(
                            'Si',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                          onPressed: () => Navigator.pop(c, true),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(100),
                        child: MaterialButton(
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                          color: Colors.orange,
                          textColor: Colors.white,
                          onPressed: () => Navigator.pop(c, false),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    final nuevoMetodoPagoBloc = ProviderBloc.nuevopago(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Pago Online',
            style: TextStyle(color: Colors.black),
          ),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
          /* actions: <Widget>[
            NavigationControls(_controller.future),
            //SampleMenu(_controller.future),
          ], */
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: StreamBuilder(
          stream: nuevoMetodoPagoBloc.estadoWebview,
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                _contenidoWebview(widget.link, nuevoMetodoPagoBloc),
                (nuevoMetodoPagoBloc.valorEstadoWe == true)
                    ? Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }

  Builder _contenidoWebview(String link, NuevoMetodoPagoBloc nuevoMetodoPagoBloc) {
    return Builder(
      builder: (BuildContext context) {
        return WebView(
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // elimine esto cuando los literales de colección se establezcan.
          // ignore: prefer_collection_literals
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          /* navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith('www.google.com')) {
                      print('blocking navigation to $request}');
                      return NavigationDecision.prevent;
                    }
                    print('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  }, */
          onPageStarted: (String url) {
            print('Page started loading: $url');
            nuevoMetodoPagoBloc.changeEstadoWebview(true);

//https://careturloreto.com/quistococha/Empresa/respuesta_pasarela/CORRECTO/

            if (url == '$apiBaseURL/Empresa/respuesta_pasarela/CORRECTO/') {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 700),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetalleTicketPage(
                      idTicket: widget.idTicket,
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            } else if (url == '$apiBaseURL/Empresa/respuesta_pasarela/CANCELADO') {
              Navigator.pushNamed(context, 'home');
              /*  ArgumentsWebview argumentsWebview = ArgumentsWebview();
                      argumentsWebview.idPedido = args.idPedido;
                      argumentsWebview.codigo = '2';

                      Navigator.pushNamed(context, 'ticket',
                          arguments: argumentsWebview); */
            } else if (url == '$apiBaseURL/Empresa/respuesta_pasarela/RECHAZADO') {
              Navigator.pushNamed(context, 'home');
              /* ArgumentsWebview argumentsWebview = ArgumentsWebview();
                      argumentsWebview.idPedido = args.idPedido;
                      argumentsWebview.codigo = '3';

                      Navigator.pushNamed(context, 'ticket',
                          arguments: argumentsWebview); */
            } else if (url == '$apiBaseURL/Empresa/respuesta_pasarela/ERROR') {
              Navigator.pushNamed(context, 'home');
              /*   ArgumentsWebview argumentsWebview = ArgumentsWebview();
                      argumentsWebview.idPedido = args.idPedido;
                      argumentsWebview.codigo = '4';

                      Navigator.pushNamed(context, 'ticket',
                          arguments: argumentsWebview); */
            }
          },
          onPageFinished: (String url) {
            nuevoMetodoPagoBloc.changeEstadoWebview(false);
            print('Page finished loading: $url');

            if (url == '$apiBaseURL/Empresa/respuesta_pasarela/CORRECTO/') {

              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 700),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetalleTicketPageOnline(
                      idTicket: widget.idTicket,
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            } else if (url == '$apiBaseURL/Empresa/respuesta_pasarela/CANCELADO') {
              Navigator.pushNamed(context, 'home');
              /* ArgumentsWebview argumentsWebview = ArgumentsWebview();
                      argumentsWebview.idPedido = args.idPedido;
                      argumentsWebview.codigo = '2';

                      Navigator.pushNamed(context, 'ticket',
                          arguments: argumentsWebview); */
            } else if (url == '$apiBaseURL/Empresa/respuesta_pasarela/RECHAZADO') {
              Navigator.pushNamed(context, 'home');
              /*  ArgumentsWebview argumentsWebview = ArgumentsWebview();
                      argumentsWebview.idPedido = args.idPedido;
                      argumentsWebview.codigo = '3';

                      Navigator.pushNamed(context, 'ticket',
                          arguments: argumentsWebview); */
            } else if (url == '$apiBaseURL/Empresa/respuesta_pasarela/ERROR') {
              Navigator.pushNamed(context, 'home');
              /* ArgumentsWebview argumentsWebview = ArgumentsWebview();
                      argumentsWebview.idPedido = args.idPedido;
                      argumentsWebview.codigo = '4';

                      Navigator.pushNamed(context, 'ticket',
                          arguments: argumentsWebview); */
            }
          },
          gestureNavigationEnabled: true,
        );
      },
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture) : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady = snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data!;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("No back history item")),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("No forward history item")),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
