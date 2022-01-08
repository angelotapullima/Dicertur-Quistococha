import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/pages/terminos_y_condiciones.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAccount extends StatefulWidget {
  final String? email;
  final String? name;
  const NewAccount({Key? key, required this.email, required this.name}) : super(key: key);

  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerApellido = TextEditingController();

  final _controller = ControllerData();
  bool? _passwordVisible;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerpassword.dispose();
    _controllerName.dispose();
    _controllerApellido.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = true;
    _controllerEmail.text = widget.email!;
    _controllerName.text = widget.name!;
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
          AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(96),
                    left: ScreenUtil().setWidth(32),
                    right: ScreenUtil().setWidth(32),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(40),
                          width: double.infinity,
                          child: Text(
                            'Crear una nueva cuenta',
                            style: TextStyle(
                              color: Color(0xffFFB240),
                              fontSize: ScreenUtil().setSp(28),
                              fontWeight: FontWeight.bold,
                            ),
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
                            controller: _controllerName,
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
                            controller: _controllerApellido,
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
                              hintText: 'Apellidos',
                              hintStyle: TextStyle(
                                color: Color(0xff808080),
                              ),
                              labelText: 'Apellidos',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(56),
                          child: TextField(
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
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(56),
                          child: TextField(
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
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(24),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                print(_controller.confirmCheck);
                                if (_controller.confirmCheck) {
                                  _controller.changeCheck(false);
                                } else {
                                  _controller.changeCheck(true);
                                }
                              },
                              child: Icon(
                                (_controller.confirmCheck) ? Icons.check_box : Icons.check_box_outline_blank,
                                color: Color(0xffffb240),
                                size: ScreenUtil().setWidth(20),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(10),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return TerminosYCondiciones();
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
                                        text: 'Términos y condiciones',
                                        style: GoogleFonts.poppins(
                                          color: Color(0xffffb240),
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontStyle: FontStyle.normal,
                                        ),
                                        /* children: [
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
                                      ], */
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
                            onPressed: () async {
                              if (_controllerName.text.isNotEmpty) {
                                if (_controllerApellido.text.isNotEmpty) {
                                  if (_controllerEmail.text.isNotEmpty) {
                                    if (_controllerpassword.text.isNotEmpty) {
                                      if (_controller.confirmCheck) {
                                        final loginApi = LoginApi();

                                        final res = await loginApi.registerUser(
                                          _controllerName.text,
                                          _controllerApellido.text,
                                          _controllerEmail.text,
                                          _controllerpassword.text,
                                        );

                                        if (res.code == '1') {
                                          final res2 = await loginApi.login(_controllerEmail.text, _controllerpassword.text);
                                          if (res2.code == '1') {
                                            Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                                          } else {
                                            showToast2('ocurrio un error', Colors.red);
                                          }
                                        } else {
                                          showToast2('ocurrio un error', Colors.red);
                                        }
                                      } else {
                                        showToast2('Por favor marque el check de Términos y condiciones', Colors.red);
                                      }
                                    } else {
                                      showToast2('Por favor ingrese su Contraseña', Colors.red);
                                    }
                                  } else {
                                    showToast2('Por favor ingrese su Email', Colors.red);
                                  }
                                } else {
                                  showToast2('Por favor ingrese su Apellido', Colors.red);
                                }
                              } else {
                                showToast2('Por favor ingrese su nombre', Colors.red);
                              }
                            },
                            color: Color(0xffffb240),
                            child: Text('Crear Cuenta'),
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(50),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Ya tengo una cuenta',
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
                );
              }),
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
