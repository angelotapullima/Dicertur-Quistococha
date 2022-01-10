import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicertur_quistococha/src/models/servicios_model.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetalleServicio extends StatelessWidget {
  const DetalleServicio({Key? key, required this.servicio, required this.hero}) : super(key: key);

  final ServicioModel servicio;
  final String hero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(250),
                child: Hero(
                  tag: '$hero',
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image(
                        image: AssetImage('assets/img/loading.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                    imageUrl: 'https://portal.andina.pe/EDPfotografia3/Thumbnail/2021/12/15/000832051W.jpg',
                    //imageUrl: '$apiBaseURL/${servicio.servicioImagen}',
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${servicio.servicioTitulo}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Text(
                      '${servicio.servicioDetalle}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(10),
              )
            ],
          ),
        )
      ],
    ));
  }
}
