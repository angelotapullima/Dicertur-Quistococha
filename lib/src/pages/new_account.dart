import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({Key key}) : super(key: key);

  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  final _controller = ControllerData();
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(),
          Container(
            width: ScreenUtil().setWidth(375),
            height: ScreenUtil().setHeight(740),
            child: SvgPicture.asset(
              'assets/svg/back_login.svg',
              fit: BoxFit.fitWidth,
            ), //Image.asset('assets/logo_largo.svg'),
          ),
          SafeArea(
            child: BackButton(),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(96),
              left: ScreenUtil().setWidth(32),
              right: ScreenUtil().setWidth(32),
            ),
            child: Column(
              children: [
                Container(
                  height: ScreenUtil().setHeight(30),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        'Crear una nueva cuenta',
                        style: TextStyle(
                          color: Color(0xffFFB240),
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(13),
                ),
                Text(
                  'Crea una cuenta para que puedas comprar entradas al complejo turístico QuistoCocha',
                  style: TextStyle(
                    color: Color(0xff808080),
                    fontSize: ScreenUtil().setSp(15),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(48),
                ),
                Container(
                  height: ScreenUtil().setHeight(56),
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xff808080),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      hintText: 'Nombre',
                      hintStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: 'Nombre',
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                Container(
                  height: ScreenUtil().setHeight(56),
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xff808080),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      hintText: 'DNI',
                      hintStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: 'DNI',
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                Container(
                  height: ScreenUtil().setHeight(56),
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xff808080),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                Container(
                  height: ScreenUtil().setHeight(56),
                  child: TextField(
                    obscureText: _passwordVisible,
                    style: TextStyle(
                      color: Color(0xff808080),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                      hintText: 'Contraseña',
                      hintStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_passwordVisible) {
                              _passwordVisible = false;
                            } else {
                              _passwordVisible = true;
                            }
                          });
                        },
                        icon: _passwordVisible
                            ? Icon(
                                Icons.visibility,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(24),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (_controller.confirmCheck) {
                          _controller.changeCheck(false);
                        } else {
                          _controller.changeCheck(true);
                        }
                      },
                      child: Icon(
                        (_controller.confirmCheck) ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Color(0xff808080),
                        size: ScreenUtil().setWidth(20),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: RichText(
                          text: TextSpan(
                            text: 'Estoy de acuerdo con los ',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(12),
                              fontStyle: FontStyle.normal,
                            ),
                            children: [
                              TextSpan(
                                text: 'Términos',
                                style: GoogleFonts.poppins(
                                  color: Color(0xffffb240),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontStyle: FontStyle.normal,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' y ',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(12),
                                      fontStyle: FontStyle.normal,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'politicas de privacidad',
                                        style: GoogleFonts.poppins(
                                          color: Color(0xffffb240),
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontStyle: FontStyle.normal,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                SizedBox(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(50),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'home');},
                    color: Color(0xffffb240),
                    child: Text('Crear Cuenta'),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Text(
                  'Ya tengo una cuenta',
                  style: TextStyle(
                    color: Color(0xff404040),
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              child: Image(
                image: AssetImage('assets/svg/banner.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ControllerData extends ChangeNotifier {
  bool confirmCheck = false;

  void changeCheck(bool c) {
    confirmCheck = c;
    notifyListeners();
  }
}
