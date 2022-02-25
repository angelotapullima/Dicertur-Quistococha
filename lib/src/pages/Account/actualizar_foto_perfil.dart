import 'dart:convert';
import 'dart:io';

import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/src/bloc/bottom_navigation_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/multipart.dart';
import 'package:dicertur_quistococha/src/utils/responsive.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ActualizarFotoPerfil extends StatefulWidget {
  const ActualizarFotoPerfil({Key? key}) : super(key: key);

  @override
  _ActualizarFotoPerfilState createState() => _ActualizarFotoPerfilState();
}

class _ActualizarFotoPerfilState extends State<ActualizarFotoPerfil> {
  ValueNotifier<bool> _cargando = ValueNotifier(false);
  TextEditingController _nombreController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 70);

    if (pickedFile != null) {
      setState(
        () {
          _cropImage(pickedFile.path);
        },
      );
    }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
    /**/
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final bottomBloc = ProviderBloc.bottom(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Actualizar foto de perfil',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w700,
            letterSpacing: ScreenUtil().setSp(0.016),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: ScreenUtil().setSp(24),
            ),
            onPressed: () {
              if (_image != null) {
                uploadImage1(_image!, _nombreController.text, context, bottomBloc);
              } else {
                utils.showToast2('Por favor seleccione una imagen', Colors.amber);
              }
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _cargando,
        builder: (BuildContext context, bool data, child) {
          return Stack(
            children: [_contenido(responsive), (data) ? _mostrarAlert(bottomBloc, responsive) : Container()],
          );
        },
      ),
    );
  }

  Widget _mostrarAlert(BottomNaviBloc bottomNaviBloc, Responsive responsive) {
    return StreamBuilder(
      stream: bottomNaviBloc.subidaImagenStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromRGBO(0, 0, 0, 0.5),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: responsive.hp(20),
                    child: CupertinoActivityIndicator(),
                  ),
                  Text(
                    '${(snapshot.data).toString()}%',
                    //'${snapshot.data}.toInt()%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.ip(1.8),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Stack _contenido(Responsive responsive) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(150),
            ),
            (_image == null)
                ? Center(
                    child: Container(
                      child: Image.asset(
                        'assets/svg/profile.png',
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(300),
                        height: ScreenUtil().setHeight(300),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: ScreenUtil().setWidth(300),
                      height: ScreenUtil().setHeight(300),
                      child: CircleAvatar(
                        backgroundImage: FileImage(_image!),
                        //radius: ScreenUtil().radius(300),
                      ),
                    ),
                  ),
          ],
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            height: responsive.hp(10),
            width: double.infinity,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Seleccionar Foto'),
                InkWell(
                  onTap: () {
                    getImageCamera();
                  },
                  child: Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.deepOrange,
                    size: ScreenUtil().setSp(35),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child: Icon(
                    Icons.photo_outlined,
                    color: Colors.deepPurple,
                    size: ScreenUtil().setSp(32),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cortar Imagen',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0, title: 'Cortar Imagen'));

    if (croppedImage != null) {
      _image = croppedImage;
      setState(() {});
    }
  }

  void uploadImage1(File _image, String nombre, BuildContext context, BottomNaviBloc bottom) async {
    _cargando.value = true;

    var stream = new http.ByteStream(
      Stream.castFrom(
        _image.openRead(),
      ),
    );

    var length = await _image.length();

    var uri = Uri.parse("$apiBaseURL/api/empresa/guardar_edicion_usuario_foto");

    final request = MultipartRequest(
      'POST',
      uri,
      onProgress: (int bytes, int total) {
        final progress = bytes / total;
        print('progress: $progress ($bytes/$total)');

        var valorCarga = (bytes / total) * 100;
        bottom.changeSubidaImagen(valorCarga);
      },
    );

    String? token = await StorageManager.readData('token');
    request.fields["app"] = "true";
    request.fields["tn"] = "$token";

    var multipartFile = new http.MultipartFile('usuario_imagen', stream, length, filename: basename(_image.path));

    request.files.add(multipartFile);

    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        final decodedData = json.decode(value);

        if (decodedData['code'].toString() == '1') {
          var path = decodedData["usuario_imagen"];
          StorageManager.saveData('userImage', '$path');
          final dataBloc = ProviderBloc.data(context);
          dataBloc.obtenerUser();
        } else {
          utils.showToast2('Hubo un error al cargar la Imagen', Colors.red);
        }

        _cargando.value = false;
        Navigator.pop(context);
      });
    }).catchError((e) {
      print(e);
    });

    _cargando.value = false;
  }
}
