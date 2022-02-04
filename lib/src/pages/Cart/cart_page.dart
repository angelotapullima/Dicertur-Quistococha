import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicertur_quistococha/database/cartDatabase.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/cart_model.dart';
import 'package:dicertur_quistococha/src/pages/Cart/pago_services.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:dicertur_quistococha/src/utils/translate_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double _panelHeightOpen;
  PanelController panelController = new PanelController();
  @override
  Widget build(BuildContext context) {
    final cartBloc = ProviderBloc.cart(context);
    cartBloc.getCart();
    _panelHeightOpen = MediaQuery.of(context).size.height * .20;
    final responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: cartBloc.cartStream,
          builder: (BuildContext context, AsyncSnapshot<List<CartModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                double total = 0.0;

                for (var i = 0; i < snapshot.data!.length; i++) {
                  total = total + double.parse('${snapshot.data![i].subtotal}');
                }
                return SlidingUpPanel(
                  maxHeight: _panelHeightOpen,
                  minHeight: responsive.hp(20),
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
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(40),
                              topRight: const Radius.circular(40),
                            ),
                            color: Color(0xff00a2ff)),
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
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Total',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(10),
                                      ),
                                      Text(
                                        'S/. ${total}0',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(15),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: ScreenUtil().setHeight(60),
                                    child: MaterialButton(
                                      color: colorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) {
                                              return PayServices(
                                                monto: total.toString(),
                                                cartList: snapshot.data!,
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
                                        //Validar
                                      },
                                      child: Text(
                                        'CONTINUAR >>',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(15),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  body: SafeArea(
                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                          vertical: ScreenUtil().setHeight(5),
                        ),
                        color: Colors.white,
                        child: Row(
                          children: [
                            BackButton(
                              color: Color(0xff00a2ff),
                            ),
                            Expanded(
                              child: Text(
                                'Carrito',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(18),
                                  color: colorPrimary,
                                ),
                              ),
                            ),
                            BackButton(
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder(
                        stream: cartBloc.cartStream,
                        builder: (BuildContext context, AsyncSnapshot<List<CartModel>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.length > 0) {
                              return Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    bottom: responsive.hp(25),
                                  ),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: ScreenUtil().setHeight(100),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: ScreenUtil().setWidth(5),
                                            vertical: ScreenUtil().setHeight(8),
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Container(
                                                  width: ScreenUtil().setWidth(100),
                                                  height: ScreenUtil().setHeight(140),
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
                                                    imageUrl: '$apiBaseURL/${snapshot.data![index].image}',
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
                                              SizedBox(
                                                width: ScreenUtil().setWidth(5),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data![index].name}',
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        letterSpacing: .5,
                                                        fontSize: ScreenUtil().setSp(13.5),
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'S/.${snapshot.data![index].subtotal}0',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: ScreenUtil().setSp(16),
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal: ScreenUtil().setWidth(20),
                                                              ),
                                                              width: ScreenUtil().setWidth(120),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () async {
                                                                      if ('${snapshot.data![index].amount}' == '1') {
                                                                        final cartDatabase = CartDatabase();

                                                                        await cartDatabase.deleteCartForIdCart('${snapshot.data![index].idCart}');
                                                                        final cartBloc = ProviderBloc.cart(context);
                                                                        cartBloc.getCart();
                                                                      } else {
                                                                        final cartDatabase = CartDatabase();

                                                                        final list = await cartDatabase.getCartForIdRelatedAndType(
                                                                            '${snapshot.data![index].idRelated}', '${snapshot.data![index].type}');
                                                                        if (list.length > 0) {
                                                                          var subtotalex = (int.parse(list[0].amount.toString()) - 1) *
                                                                              double.parse('${snapshot.data![index].price}');
                                                                          CartModel cartModel = CartModel();
                                                                          cartModel.idCart = list[0].idCart;
                                                                          cartModel.idRelated = '${snapshot.data![index].idRelated}';
                                                                          cartModel.type = list[0].type;
                                                                          cartModel.amount = (int.parse(list[0].amount.toString()) - 1).toString();
                                                                          cartModel.subtotal = subtotalex.toString();

                                                                          await cartDatabase.updateCart(cartModel);
                                                                        }
                                                                      }
                                                                      final cartBloc = ProviderBloc.cart(context);
                                                                      cartBloc.getCart();
                                                                    },
                                                                    child: Container(
                                                                      height: ScreenUtil().setHeight(30),
                                                                      width: ScreenUtil().setHeight(30),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(600),
                                                                        border: Border.all(color: Colors.grey),
                                                                        color: Colors.white,
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          '-',
                                                                          style: TextStyle(
                                                                            fontSize: ScreenUtil().setSp(16),
                                                                            color: Colors.grey.shade700,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${snapshot.data![index].amount}',
                                                                    style: TextStyle(fontSize: ScreenUtil().setSp(15), color: Color(0xff00a2ff)),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () async {
                                                                      final cartDatabase = CartDatabase();

                                                                      final list = await cartDatabase.getCartForIdRelatedAndType(
                                                                          '${snapshot.data![index].idRelated}', '${snapshot.data![index].type}');
                                                                      if (list.length > 0) {
                                                                        var subtotalex = (1 + int.parse(list[0].amount.toString())) *
                                                                            double.parse('${snapshot.data![index].price}');
                                                                        CartModel cartModel = CartModel();
                                                                        cartModel.idCart = list[0].idCart;
                                                                        cartModel.idRelated = '${snapshot.data![index].idRelated}';
                                                                        cartModel.type = list[0].type;
                                                                        cartModel.amount = (1 + int.parse(list[0].amount.toString())).toString();
                                                                        cartModel.subtotal = subtotalex.toString();

                                                                        await cartDatabase.updateCart(cartModel);
                                                                      }
                                                                      final cartBloc = ProviderBloc.cart(context);
                                                                      cartBloc.getCart();

                                                                      // _controller.changeCantidad(1);
                                                                    },
                                                                    child: Container(
                                                                      height: ScreenUtil().setHeight(30),
                                                                      width: ScreenUtil().setHeight(30),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(600),
                                                                        border: Border.all(color: colorPrimary),
                                                                        color: colorPrimary,
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          '+',
                                                                          style: TextStyle(
                                                                            fontSize: ScreenUtil().setSp(16),
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return CupertinoActivityIndicator();
                            }
                          } else {
                            return CupertinoActivityIndicator();
                          }
                        },
                      ),
                    ],
                  )),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                        vertical: ScreenUtil().setHeight(5),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: [
                          BackButton(
                            color: Color(0xff00a2ff),
                          ),
                          Expanded(
                            child: Text(
                              'Carrito',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(18),
                                color: colorPrimary,
                              ),
                            ),
                          ),
                          BackButton(
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Text('No hay productos'),
                  ],
                );
              }
            } else {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10),
                      vertical: ScreenUtil().setHeight(5),
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        BackButton(
                          color: Color(0xff00a2ff),
                        ),
                        Expanded(
                          child: Text(
                            'Carrito',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(18),
                              color: colorPrimary,
                            ),
                          ),
                        ),
                        BackButton(
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  CupertinoActivityIndicator(),
                ],
              );
            }
          }),
    );
  }
}
