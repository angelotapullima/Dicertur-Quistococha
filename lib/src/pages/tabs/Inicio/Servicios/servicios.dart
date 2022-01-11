import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/servicios_model.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Servicios/detalle_servicio.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviciosBloc = ProviderBloc.servi(context);
    serviciosBloc.getCuentos();

    return StreamBuilder(
        stream: serviciosBloc.servicioStream,
        builder: (context, AsyncSnapshot<List<ServicioModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, x) {
                    var valorHero = x % 2 == 0;


                    var valorHero2 = math.Random().nextDouble() * x;

                    return InkWell(
                      onTap: () {
                       Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return DetalleServicio(hero: valorHero2.toString(), servicio: snapshot.data![x]);
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(5),
                                vertical: ScreenUtil().setHeight(5),
                              ),
                              /* padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(5),
                                vertical: ScreenUtil().setHeight(10),
                              ), */
                              child: Hero(
                                tag: '$valorHero2',
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Center(
                                        child: CupertinoActivityIndicator(),
                                      )),
                                  errorWidget: (context, url, error) => Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Center(
                                      child: Icon(Icons.error),
                                    ),
                                  ),
                                  imageUrl: '$apiBaseURL/${snapshot.data![x].servicioImagen}',
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
                            
                            (valorHero)
                                ? Positioned(
                                    left: 10,
                                    top: 10,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(10),
                                        vertical: ScreenUtil().setHeight(10),
                                      ),
                                      child: Text(
                                        '${snapshot.data![x].servicioTitulo}',
                                        style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(10),
                                        vertical: ScreenUtil().setHeight(10),
                                      ),
                                      child: Text(
                                        '${snapshot.data![x].servicioTitulo}',
                                        style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text('No tenemos Servicios disponibles en estos momentos'),
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
