import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/cart_model.dart';
import 'package:dicertur_quistococha/src/pages/Cart/cart_page.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartBloc = ProviderBloc.cart(context);
    cartBloc.getCart();
    final responsive = Responsive.of(context);
    return StreamBuilder(
      stream: cartBloc.cartStream,
      builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
        int cantidad = 0;
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            for (int i = 0; i < snapshot.data!.length; i++) {
              cantidad++;
            }

            return Stack(
              children: [
                (cantidad != 0)
                    ? Stack(
                        children: <Widget>[
                          cartcito(context),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              child: Text(
                                cantidad.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.ip(1),
                                ),
                              ),
                              alignment: Alignment.center,
                              width: responsive.ip(2),
                              height: responsive.ip(2),
                              decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                            ),
                            //child: Icon(Icons.brightness_1, size: 8,color: Colors.redAccent,  )
                          )
                        ],
                      )
                    : cartcito(context)
              ],
            );
          } else {
            return cartcito(context);
          }
        } else {
          return cartcito(context);
        }
      },
    );
  }

  Widget cartcito(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return CartPage();
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
          vertical: ScreenUtil().setHeight(7),
        ),
        decoration: BoxDecoration(
          color: colorPrimary,
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
          'assets/svg/cart.svg',
          color: Colors.white,
        ),
      ),
    );
  }
}
