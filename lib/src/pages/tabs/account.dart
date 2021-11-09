import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Cuenta',
          style: GoogleFonts.poppins(
            color: Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Center(
              child: Container(
                width: ScreenUtil().setWidth(100),
                height: ScreenUtil().setHeight(100),
                child: Image.asset('assets/svg/profile.png')
              ),
            ), 
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Center(
              child: Text(
                'BufeoTec',
                style: GoogleFonts.poppins(
                  color: Color(0XFF3A3A3A),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.16,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            InkWell(onTap: () {}, child: _itemsConfig('user', 'Cuenta')),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            
           
            InkWell(onTap: () {}, child: _itemsConfig('archive', 'Recibos')),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('file', 'Términos de uso'),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('policies', 'Políticas de privacidad'),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('help', 'Ayuda'),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('version', 'v.1.0.0'),
            SizedBox(
              height: ScreenUtil().setHeight(46),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(10)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Color(0xffffb240),
                ),
                child: Text(
                  'Cerrar sesión',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemsConfig(String icon, String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
      child: Row(
        children: [
          Container(
            height: ScreenUtil().setHeight(24),
            width: ScreenUtil().setWidth(24),
            child: SvgPicture.asset('assets/settings_svg/$icon.svg'),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(16),
          ),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0XFF585858),
            size: ScreenUtil().setHeight(16),
          )
        ],
      ),
    );
  }
  

 Uint8List _imageFile;
  List<String> imagePaths = [];
  ScreenshotController screenshotController = ScreenshotController();
  
  takeScreenshotandShare() async {
    var now = DateTime.now();
    var nombre = now.microsecond.toString();
    _imageFile = null;
    screenshotController.capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0).then((Uint8List image) async {
      setState(() {
        _imageFile = image;
      });

      await ImageGallerySaver.saveImage(image);

      // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver
      print("File Saved to Gallery");

      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile;
      File imgFile = new File('$directory/Screenshot$nombre.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");

      imagePaths.clear();
      imagePaths.add(imgFile.path);
      if (imagePaths.isNotEmpty) {
        await Future.delayed(
          Duration(seconds: 1),
        );

        ShareExtend.shareMultiple(imagePaths, "image", subject: "goleadores");
      } else {
        //showToast2('Ocurrio un error', Colors.yellow);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
 