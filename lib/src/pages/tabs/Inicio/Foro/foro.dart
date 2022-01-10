import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/foro_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForoPage extends StatelessWidget {
  const ForoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foroBloc = ProviderBloc.foro(context);
    foroBloc.getForos();

    return StreamBuilder(
        stream: foroBloc.foroStream,
        builder: (context, AsyncSnapshot<List<ForoModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                    child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                            vertical: ScreenUtil().setHeight(8),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(),
                              SizedBox(
                                width: ScreenUtil().setWidth(5),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data![index].personaName} ${snapshot.data![index].personaSurName}',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff505050),
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data![index].foroDatetime}',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Color(0xffa1a1a1),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(200),
                          decoration: BoxDecoration(),
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
                            imageUrl: '$apiBaseURL/${snapshot.data![index].foroImagen}',
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                          ),
                          child: Text('${snapshot.data![index].foroDetalle}'),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return StreamBuilder(
                  stream: foroBloc.cargandoStream,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return (snapshot.data!)
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Center(
                              child: Text(
                                'No tenemos publicaciones disponibles en estos momentos',
                                textAlign: TextAlign.center,
                              ),
                            );
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
}
