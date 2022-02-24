import 'package:dicertur_quistococha/src/api/cuenta_api.dart';
import 'package:dicertur_quistococha/src/bloc/data_user.dart';
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoPController = TextEditingController();
  TextEditingController _apellidoMController = TextEditingController();
  TextEditingController _nacimientoController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();

  final _controller = EditController();

  @override
  void initState() {
    _nombreController.text = widget.user.personName.toString();
    _apellidoPController.text = widget.user.personSurnameP.toString();
    _apellidoMController.text = widget.user.personSurnameM.toString();
    _nacimientoController.text = widget.user.nacimiento.toString();
    _telefonoController.text = widget.user.telefono.toString();
    super.initState();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            child: Image.asset('assets/img/foto perfil.png'),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Editar',
                    style: GoogleFonts.poppins(
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    'Cuenta',
                    style: GoogleFonts.poppins(
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  _items('Nombre', _nombreController, TextInputType.text),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  _items('Apellido Paterno', _apellidoPController, TextInputType.text),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  _items('Apellido Materno', _apellidoMController, TextInputType.text),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  _items('Nro de Celular', _telefonoController, TextInputType.number),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(100),
                        child: Text(
                          'Fecha de Nacimiento',
                          style: GoogleFonts.poppins(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF7C828F),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(12),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _nacimientoController,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _selectdate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  InkWell(
                    onTap: () async {
                      _controller.chnageCargando(true);
                      if (_nombreController.text.isNotEmpty) {
                        if (_apellidoPController.text.isNotEmpty) {
                          _controller.chnageCargando(true);
                          final _cuentaApi = CuentaApi();
                          UserModel user = UserModel();
                          user.idPerson = widget.user.idPerson;
                          user.personName = _nombreController.text;
                          user.personSurnameP = _apellidoPController.text;
                          user.personSurnameM = _apellidoMController.text;
                          user.telefono = _telefonoController.text;
                          user.nacimiento = _nacimientoController.text;

                          final res = await _cuentaApi.editAccount(user);
                          if (res.code == '1') {
                            final dataBloc = ProviderBloc.data(context);
                            dataBloc.obtenerUser();

                            showToast2('Editado correctamente', Colors.black);
                            Navigator.pop(context);
                          } else {
                            showToast2(res.message.toString(), Colors.red);
                          }
                          _controller.chnageCargando(false);
                        } else {
                          showToast2('Debe ingresar el apellido paterno', Colors.red);
                        }
                      } else {
                        showToast2('Debe ingresar un nombre', Colors.red);
                      }
                      _controller.chnageCargando(false);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 8,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Guardar',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (_, s) {
                return (_controller.cargando)
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : Container();
              }),
        ],
      ),
    );
  }

  Row _items(String titulo, TextEditingController controller, TextInputType type) {
    return Row(
      children: [
        Container(
          width: ScreenUtil().setWidth(100),
          child: Text(
            titulo,
            style: GoogleFonts.poppins(
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w600,
              color: Color(0XFF7C828F),
            ),
          ),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(12),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(4),
              hintText: titulo,
              counterText: '',
              hintStyle: GoogleFonts.poppins(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w400,
                  letterSpacing: ScreenUtil().setSp(0.016),
                  fontStyle: FontStyle.normal),
            ),
            style: GoogleFonts.poppins(
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w400,
              letterSpacing: ScreenUtil().setSp(0.016),
            ),
          ),
        ),
      ],
    );
  }

  _selectdate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 60),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );

    print('date $picked');
    _nacimientoController.text =
        "${picked!.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

    // setState(() {
    //   fechaDato = "${picked!.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    //   //inputfieldDateController.text = fechaDato;

    //   print(fechaDato);
    // });
  }
}

class EditController extends ChangeNotifier {
  bool cargando = false;

  void chnageCargando(bool c) {
    cargando = c;
    notifyListeners();
  }
}
