import 'package:dicertur_quistococha/src/bloc/data_user.dart';
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
          InkWell(
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              _items('Nombre', _nombreController),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              _items('Apellido Paterno', _apellidoPController),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              _items('Apellido Materno', _apellidoMController),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              _items('Nro de Celular', _telefonoController),
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
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(150),
                  child: Image.asset('assets/img/foto perfil.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _items(String titulo, TextEditingController controller) {
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
