import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:dicertur_quistococha/src/widget/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  bool? _passwordVisible;

  final _controller = ControllerLogin();

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
                      Expanded(
                        child: Text(
                          'Bienvenido de vuelta ',
                          style: TextStyle(
                            color: Color(0xffFFB240),
                            fontSize: ScreenUtil().setSp(28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(30),
                        height: ScreenUtil().setHeight(30),
                        child: SvgPicture.asset(
                          'assets/svg/emoji.svg',
                          fit: BoxFit.fitWidth,
                        ), //Image.asset('assets/logo_largo.svg'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(13),
                ),
                Text(
                  'Estamos felices de que regreses. Puede continuar iniciando sesión para comprar sus entradas.',
                  style: TextStyle(
                    color: Color(0xff808080),
                    fontSize: ScreenUtil().setSp(15),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(48),
                ),
                TextField(
                  controller: _controllerEmail,
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
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                TextField(
                  controller: _controllerpassword,
                  obscureText: _passwordVisible!,
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
                          if (_passwordVisible!) {
                            _passwordVisible = false;
                          } else {
                            _passwordVisible = true;
                          }
                        });
                      },
                      icon: _passwordVisible!
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
                SizedBox(
                  height: ScreenUtil().setHeight(24),
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: Color(0xffFFB240),
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(132),
                ),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      if (_controllerEmail.text.length > 0) {
                        if (_controllerpassword.text.length > 0) {
                          _controller.changeLoadding(true);
                          final _login = LoginApi();
                          final res = await _login.login(_controllerEmail.text, _controllerpassword.text);

                          if (res.code == '1') {
                            Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                          } else {
                            showToast2(res.message!, Colors.black);
                          }
                          _controller.changeLoadding(false);
                        } else {
                          showToast2('Ingrese su contraseña', Colors.black);
                        }
                      } else {
                        showToast2('Ingrese su usuario', Colors.black);
                      }
                    },
                    color: Color(0xffffb240),
                    child: Text('Ingresar'),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(80),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'newAccount');
                  },
                  child: Text(
                    'No tengo una cuenta',
                    style: TextStyle(
                      color: Color(0xff404040),
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600,
                    ),
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
          AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              return ShowLoadding(
                w: double.infinity,
                h: double.infinity,
                colorText: Colors.black,
                fondo: Colors.black.withOpacity(0.3),
                active: _controller.loadding,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ControllerLogin extends ChangeNotifier {
  bool loadding = false;
  void changeLoadding(bool v) {
    loadding = v;
    notifyListeners();
  }
}
