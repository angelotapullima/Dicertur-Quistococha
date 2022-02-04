
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/cuentos_model.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Cuentos/detalle_cuentos.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';

class CuentosPage extends StatelessWidget {
  const CuentosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cuentosBloc = ProviderBloc.cuentos(context);
    cuentosBloc.getCuentos();

    return StreamBuilder(
        stream: cuentosBloc.cuentosStream,
        builder: (context, AsyncSnapshot<List<CuentosModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Container(
                child: CarouselSlider.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, x, y) {
                    var valorHero = math.Random().nextDouble() * x;

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return DetalleCuentos(hero: valorHero.toString(), cuentos: snapshot.data![x]);
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
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 8,
                              offset: Offset(1, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5), vertical: ScreenUtil().setHeight(10)),
                                child: Hero(
                                  tag: '$valorHero',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
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
                                      imageUrl: '$apiBaseURL/${snapshot.data![x].cuentoImagen}',
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      height: ScreenUtil().setHeight(552),
                      onPageChanged: (index, page) {},
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayInterval: Duration(seconds: 6),
                      autoPlayAnimationDuration: Duration(milliseconds: 2000),
                      viewportFraction: 0.8),
                ),
              );
            } else {
              return Center(
                child: Text('No tenemos cuentos en estos momentos'),
              );
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }
}
