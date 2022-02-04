

import 'package:dicertur_quistococha/src/api/ticket_api.dart';
import 'package:dicertur_quistococha/src/models/cart_model.dart';
import 'package:dicertur_quistococha/src/pages/web_view_pago_tickets.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:dicertur_quistococha/src/widget/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PayServices extends StatefulWidget {
  final String monto;
  final List<CartModel> cartList;
  const PayServices({Key? key,required this.monto,required this.cartList}) : super(key: key);

  @override
  State<PayServices> createState() => _PayServicesState();
}

class _PayServicesState extends State<PayServices> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _telController = TextEditingController();

  final TextEditingController _dirController = TextEditingController();
  final _controller = ValidarDatosController();

  final items = ['DNI', 'RUC', 'Carnet de extranjería', 'Pasaporte'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,iconTheme: IconThemeData(color: Color(0xff00a2ff)),),
      body: Stack(
        children: [
          Column(
            children: [ SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(10)),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff323232).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Seleccione tipo de comprobante',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (_, t) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  _controller.changeDoc('03');
                                  _controller.changeTipoDocumento('DNI');
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: ScreenUtil().setHeight(20),
                                      width: ScreenUtil().setWidth(20),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (_controller.tipoDoc == '03') ? colorPrimary : const Color(0XFFf7f7f7),
                                        border: Border.all(
                                          color: const Color(0XFFF7F7F7),
                                          width: ScreenUtil().setWidth(4),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    Text(
                                      'Boleta',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF585858),
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: (_controller.tipoDoc == '03') ? FontWeight.w500 : FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(60),
                              ),
                              InkWell(
                                onTap: () {
                                  _controller.changeDoc('01');
                                  _controller.changeTipoDocumento('RUC');
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: ScreenUtil().setHeight(20),
                                      width: ScreenUtil().setWidth(20),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (_controller.tipoDoc == '01') ? colorPrimary : const Color(0XFFF7F7F7),
                                        border: Border.all(
                                          color: const Color(0XFFF7F7F7),
                                          width: ScreenUtil().setWidth(4),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    Text(
                                      'Factura',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF585858),
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: (_controller.tipoDoc == '01') ? FontWeight.w500 : FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (_, sd) {
                    return (_controller.tipoDoc != '')
                        ? Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(10)),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff323232).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Complete los campos',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(8),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButton<String>(dropdownColor: Colors.white,
                                          isExpanded: true,
                                          value: _controller.tipoDocIdentificacion,
                                          items: items.map(crearItems).toList(),
                                          onChanged: (item) {
                                            _controller.changeTipoDocumento(item.toString());
                                          },
                                          style: GoogleFonts.poppins(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            letterSpacing: ScreenUtil().setSp(0.016),
                                          ),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: ScreenUtil().setHeight(45),
                                        child: TextField(
                                          controller: _dniController,
                                          maxLines: 1,
                                          keyboardType: (_controller.maxCarateresDoc == 8 || _controller.maxCarateresDoc == 11)
                                              ? TextInputType.number
                                              : TextInputType.text,
                                          maxLength: _controller.maxCarateresDoc,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(4),
                                            suffixIcon: Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                              size: ScreenUtil().setHeight(18),
                                            ),
                                            hintText: 'Nro de documento',
                                            counterText: '',
                                            labelText: 'Nro de documento',
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: ScreenUtil().setSp(0.016),
                                                fontStyle: FontStyle.normal),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                          ),
                                          style: GoogleFonts.poppins(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: ScreenUtil().setSp(0.016),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: ScreenUtil().setHeight(45),
                                        child: TextField(
                                          controller: _nombreController,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(4),
                                            suffixIcon: Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                              size: ScreenUtil().setHeight(18),
                                            ),
                                            hintText: 'Nombre',
                                            labelText: 'Nombre',
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: ScreenUtil().setSp(0.016),
                                                fontStyle: FontStyle.normal),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                          ),
                                          style: GoogleFonts.poppins(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: ScreenUtil().setSp(0.016),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: ScreenUtil().setHeight(45),
                                        child: TextField(
                                          controller: _telController,
                                          maxLines: 1,
                                          maxLength: 9,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(4),
                                            suffixIcon: Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                              size: ScreenUtil().setHeight(18),
                                            ),
                                            hintText: 'Teléfono',
                                            labelText: 'Teléfono',
                                            counterText: '',
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: ScreenUtil().setSp(0.016),
                                                fontStyle: FontStyle.normal),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                          ),
                                          style: GoogleFonts.poppins(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: ScreenUtil().setSp(0.016),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                (_controller.tipoDoc == '01')
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: ScreenUtil().setHeight(35),
                                              child: TextField(
                                                controller: _dirController,
                                                maxLines: 1,
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.all(4),
                                                  suffixIcon: Icon(
                                                    Icons.edit,
                                                    color: Colors.grey,
                                                    size: ScreenUtil().setHeight(18),
                                                  ),
                                                  hintText: 'Dirección',
                                                  counterText: '',
                                                  labelText: 'Dirección',
                                                  hintStyle: GoogleFonts.poppins(
                                                      fontSize: ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: ScreenUtil().setSp(0.016),
                                                      fontStyle: FontStyle.normal),
                                                  enabledBorder: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  border: InputBorder.none,
                                                ),
                                                style: GoogleFonts.poppins(
                                                  fontSize: ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: ScreenUtil().setSp(0.016),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                                (_controller.tipoDoc == '01') ? Divider() : Container(),
                              ],
                            ),
                          )
                        : Container();
                  }),
              SizedBox(
                height: ScreenUtil().setHeight(100),
              )
            ],
          ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () async {
                _controller.changeLoadding(true);
                if (_controller.tipoDoc != '') {
                  if (_dniController.text.isNotEmpty) {
                    if (_nombreController.text.isNotEmpty) {
                      if (_telController.text.isNotEmpty) {
                        if (_controller.tipoDoc == '01' && _dirController.text.isEmpty) {
                          showToast2('Ingrese dirección', Colors.black);
                        } else {
                          if (_dniController.text.length < _controller.maxCarateresDoc) {
                            showToast2(
                                'El ${_controller.tipoDocIdentificacion} debe contener ${_controller.maxCarateresDoc} caracteres', Colors.black);
                          } else {
                            final _ticketApi = TicketApi();
                            String detalle = '';
                            for (var i = 0; i < widget.cartList.length; i++) {
                              detalle += '${widget.cartList[i].amount},${widget.cartList[i].price},${widget.cartList[i].name}//--';
                            }

                            final res = await _ticketApi.guardarServices(
                                widget.monto,
                                detalle,
                                _nombreController.text,
                                _telController.text,
                                _dniController.text,
                                _controller.idTipoDocIdentifiacion,
                                _dirController.text,
                                _controller.tipoDoc);

                            if (res.code == '1') {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return WebViewPagosTickets(
                                      link: res.url.toString(),
                                      idTicket: res.idTicket.toString(),
                                    );
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
                            } else {
                              showToast2(res.message.toString(), Colors.black);
                            }
                          } 
                        }
                      } else {
                        showToast2('Ingrese teléfono', Colors.black);
                      }
                    } else {
                      showToast2('Ingrese nombre', Colors.black);
                    }
                  } else {
                    showToast2('Ingrese Nro de documento', Colors.black);
                  }
                } else {
                  showToast2('Seleccione tipo de documento', Colors.black);
                }

                _controller.changeLoadding(false);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF8A62C),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF8A62C).withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 12,
                      offset: Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(20),
                ),
                height: kBottomNavigationBarHeight + ScreenUtil().setHeight(5),
                child: Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Text(
                      'Confirmar Pago',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'S/ ${widget.monto}0',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(20),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    )
                  ],
                ),
              ),
            ),
          ),
        AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              return ShowLoadding(
                w: double.infinity,
                h: double.infinity,
                colorText: Colors.yellow,
                fondo: Colors.black.withOpacity(0.3),
                active: _controller.loadding,
              );
            },
          ),  ],
      ),
    );
  }

  DropdownMenuItem<String> crearItems(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }
}

class ValidarDatosController extends ChangeNotifier {
  bool loadding = false;
  String tipoDoc = '';
  int maxCarateresDoc = 8;
  String idTipoDocIdentifiacion = '2';

  String tipoDocIdentificacion = 'DNI';
  void changeLoadding(bool v) {
    loadding = v;
    notifyListeners();
  }

  void changeDoc(String d) {
    tipoDoc = d;
    notifyListeners();
  }

  void changeTipoDocumento(String t) {
    tipoDocIdentificacion = t;

    if (t == 'DNI') {
      maxCarateresDoc = 8;
      idTipoDocIdentifiacion = '2';
    } else if (t == 'RUC') {
      maxCarateresDoc = 11;
      idTipoDocIdentifiacion = '4';
    } else if (t == 'Carnet de extranjería') {
      maxCarateresDoc = 12;
      idTipoDocIdentifiacion = '3';
    } else if (t == 'Pasaporte') {
      maxCarateresDoc = 12;
      idTipoDocIdentifiacion = '5';
    }
    notifyListeners();
  }
}
