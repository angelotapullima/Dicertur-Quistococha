import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/souvenir_model.dart';
import 'package:dicertur_quistococha/src/pages/tabs/Inicio/Souvenirs/detalle_souvenir.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SourvenirPage extends StatelessWidget {
  const SourvenirPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourvenirBloc = ProviderBloc.sou(context);
    sourvenirBloc.getSouvenir();

    return StreamBuilder(
        stream: sourvenirBloc.souvenirStream,
        builder: (context, AsyncSnapshot<List<SourvenirModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Container(
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return LayoutBuilder(builder: (context, constrain) {
                      return InkWell(
                        onTap: (){ Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return DetailSouvenir(
                                      sourvenirModel: snapshot.data![index], 
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
                              
                              
                              },
                        child: Hero(tag: '${snapshot.data![index].idProduct}-2',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 12,
                                    offset: Offset(-5, 8), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(5),
                                vertical: ScreenUtil().setHeight(5),
                              ),
                              height: constrain.minHeight,
                              width: constrain.maxWidth,
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: constrain.minHeight * .65,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
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
                                            imageUrl: '$apiBaseURL/${snapshot.data![index].productImagen}',
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
                                      Text(
                                        ' ${snapshot.data![index].productTitle} ',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(15),
                                        ),
                                      ),
                                      Text(
                                        ' ${snapshot.data![index].productDetail} ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff00a2ff),
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(5),
                                    ),
                                    child: Text(
                                      'S/.${snapshot.data![index].productPrecio}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              );
            } else {
              return Center(
                child: Text('no existen fotos en la galería'),
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
