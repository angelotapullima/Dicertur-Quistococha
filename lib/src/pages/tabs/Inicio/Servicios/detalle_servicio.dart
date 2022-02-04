import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicertur_quistococha/database/cartDatabase.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/cart_model.dart';
import 'package:dicertur_quistococha/src/models/servicios_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:dicertur_quistococha/src/utils/translate_animation.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:dicertur_quistococha/src/widget/cart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetalleServicio extends StatefulWidget {
  DetalleServicio({Key? key, required this.servicio, required this.hero}) : super(key: key);

  final ServicioModel servicio;
  final String hero;

  @override
  State<DetalleServicio> createState() => _DetalleServicioState();
}

class _DetalleServicioState extends State<DetalleServicio> {
  final _controller = Controller();
  late double _panelHeightOpen;
  PanelController panelController = new PanelController();
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    _panelHeightOpen = MediaQuery.of(context).size.height * .90;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (_, t) {
            return Stack(
              children: [
                SlidingUpPanel(
                  maxHeight: _panelHeightOpen,
                  minHeight: responsive.hp(60),
                  controller: panelController,
                  parallaxEnabled: true,
                  parallaxOffset: 0.1,
                  backdropEnabled: true,
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(40),
                    topRight: const Radius.circular(40),
                  ),
                  panelBuilder: (sc) {
                    return TranslateAnimation(
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                          vertical: ScreenUtil().setHeight(20),
                        ),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${widget.servicio.servicioTitulo}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(10),
                                      ),
                                      Text(
                                        'S/${widget.servicio.servicioPrecio}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(12),
                                  ),
                                  Text(
                                    '${widget.servicio.servicioDetalle}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  body: Stack(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(350),
                        child: Hero(
                          tag: '${widget.hero}',
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                            imageUrl: '$apiBaseURL/${widget.servicio.servicioImagen}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ScreenUtil().setHeight(30),
                        left: ScreenUtil().setWidth(25),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(7),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.6),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: colorPrimary.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 12,
                                  offset: Offset(0, 8), // changes position of shadow
                                ),
                              ],
                            ),
                            height: ScreenUtil().setHeight(40),
                            width: ScreenUtil().setHeight(40),
                            child: SvgPicture.asset(
                              'assets/svg/arrow_left.svg',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ScreenUtil().setHeight(30),
                        right: ScreenUtil().setWidth(25),
                        child: CartWidget(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 20,
                  left: 20,
                  child: TranslateAnimation(
                    duration: const Duration(milliseconds: 800),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20),
                                  ),
                                  width: ScreenUtil().setWidth(120),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: colorPrimary),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _controller.changeCantidad(-1);
                                        },
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(20),
                                            color: colorPrimary,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${_controller.cantidad}',
                                        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _controller.changeCantidad(1);
                                        },
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(20),
                                            color: colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(10),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              dialiogCart(
                                context,
                                responsive,
                                widget.servicio,
                                _controller.cantidad.toString(),
                              );
                            },
                            color: Color(0xffffaf04),
                            child: Row(
                              children: [
                                Container(
                                  height: ScreenUtil().setHeight(20),
                                  width: ScreenUtil().setHeight(20),
                                  child: SvgPicture.asset(
                                    'assets/svg/cart.svg',
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(10),
                                ),
                                Text(
                                  'Agregar al carrito',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Future<dynamic> dialiogCart(
    BuildContext context,
    Responsive responsive,
    ServicioModel servicioModel,
    String cantidad,
  ) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          content: Container(
            width: responsive.wp(90),
            height: responsive.hp(28),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Elige una opción',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () async {
                      final cartDatabase = CartDatabase();

                      final list = await cartDatabase.getCartForIdRelatedAndType(servicioModel.idServicio.toString(), '1');
                      if (list.length > 0) {
                        var subtotalex = (double.parse(cantidad) + double.parse(list[0].amount.toString())) *
                            double.parse(servicioModel.servicioPrecio.toString());
                        CartModel cartModel = CartModel();
                        cartModel.idCart = list[0].idCart;
                        cartModel.idRelated = servicioModel.idServicio;
                        cartModel.type = '1';
                        cartModel.amount = (int.parse(cantidad) + int.parse(list[0].amount.toString())).toString();
                        cartModel.subtotal = subtotalex.toString();

                        await cartDatabase.updateCart(cartModel);
                      } else {
                        var subtotalex = double.parse(cantidad) * double.parse(servicioModel.servicioPrecio.toString());
                        CartModel cartModel = CartModel();
                        cartModel.idRelated = servicioModel.idServicio;
                        cartModel.amount = cantidad;
                        cartModel.type = '1';
                        cartModel.subtotal = subtotalex.toString();

                        await cartDatabase.insertCart(cartModel);
                      }

                      showToast2('Agregado al carrito correctamente', Colors.green);
                      final cartBloc = ProviderBloc.cart(context);
                      cartBloc.getCart();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: ScreenUtil().setHeight(30),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                        Expanded(
                          child: Text('Agregar al carrito'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: ScreenUtil().setHeight(30),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                        Expanded(
                          child: Text('Seguir buscando'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Controller extends ChangeNotifier {
  int cantidad = 1;

  void changeCantidad(int c) {
    if (cantidad == 1 && c == -1) {
      cantidad = 1;
    } else {
      if (cantidad > 0) {
        cantidad = cantidad + c;
      } else {
        cantidad = 1;
      }
    }

    notifyListeners();
  }
}
