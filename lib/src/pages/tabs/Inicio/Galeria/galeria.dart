import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/galeria_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GaleriaPage extends StatelessWidget {
  const GaleriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final galeriaBloc = ProviderBloc.galeria(context);
    galeriaBloc.getGaleria();

    return StreamBuilder(
        stream: galeriaBloc.galeriaStream,
        builder: (context, AsyncSnapshot<List<GaleriaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Container(
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (c) => Dialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ), //this right here
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                ),
                                InteractiveViewer(
                                  clipBehavior: Clip.none,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                      // height: ScreenUtil().setHeight(600),
                                      //width: ScreenUtil().setWidth(400),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
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
                                          imageUrl: '$apiBaseURL/${snapshot.data![index].galeriaFoto}',
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: LayoutBuilder(builder: (context, constrain) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(5),
                              vertical: ScreenUtil().setHeight(5),
                            ),
                            height: constrain.minHeight,
                            width: constrain.maxWidth,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
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
                                imageUrl: '$apiBaseURL/${snapshot.data![index].galeriaFoto}',
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
                        );
                      }),
                    );
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
