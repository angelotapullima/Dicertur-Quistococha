import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/evento_model.dart';
import 'package:dicertur_quistococha/src/models/tarifa_model.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:dicertur_quistococha/src/widget/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MostrarTarifas extends StatefulWidget {
  const MostrarTarifas({Key? key, required this.fecha}) : super(key: key);
  final String fecha;

  @override
  _MostrarTarifasState createState() => _MostrarTarifasState();
}

class _MostrarTarifasState extends State<MostrarTarifas> {
  void llamado() {
    setState(() {});
  }

  final _controller = TarifasController();

  @override
  Widget build(BuildContext context) {
    final eventoBloc = ProviderBloc.evento(context);
    eventoBloc.obtenerEventoFecha(widget.fecha);

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: eventoBloc.eventoStream,
          builder: (context, AsyncSnapshot<List<EventoModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                var evento = snapshot.data![0];
                eventoBloc.obtenerTarifas(evento.espacio![0].idEspacio.toString());
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: ScreenUtil().setWidth(0),
                            ),
                            Text(
                              '${evento.eventoNombre!.toUpperCase()} - ${evento.espacio![0].espacioNombre!.toUpperCase()}',
                              style: GoogleFonts.poppins(
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF707070),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tarifas',
                              style: GoogleFonts.poppins(
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF707070),
                              ),
                            ),
                            Text(
                              'Disponible: ${evento.espacio![0].espacioAforo}',
                              style: GoogleFonts.poppins(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF707070),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: eventoBloc.tarifaStream,
                              builder: (context, AsyncSnapshot<List<TarifaModel>> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.length > 0) {
                                    var tarifas = snapshot.data!;
                                    List<int> array = [];
                                    for (var i = 0; i < tarifas.length; i++) {
                                      array.add(0);
                                    }
                                    _controller.changeArray(array);
                                    return ListView.builder(
                                        itemCount: tarifas.length,
                                        itemBuilder: (_, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${tarifas[index].tarifaNombre}',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: ScreenUtil().setSp(16),
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0XFF505050),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  _cantidad(_controller.array[index], index)
                                                ],
                                              ),
                                              Divider(),
                                            ],
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: Text('Sin tarifas disponibles'),
                                    );
                                  }
                                } else {
                                  return ShowLoadding(
                                    w: double.infinity,
                                    h: double.infinity,
                                    colorText: Colors.yellow,
                                    fondo: Colors.transparent,
                                    active: true,
                                  );
                                }
                              }),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            int disponile = int.parse(evento.espacio![0].espacioAforo.toString());
                            num tarifaSeleccionado = 0;
                            for (var i = 0; i < _controller.array.length; i++) {
                              tarifaSeleccionado = tarifaSeleccionado + _controller.array[i];
                            }

                            if (tarifaSeleccionado <= disponile) {
                              showToast2('Puede seguir', Colors.black);
                            } else {
                              showToast2('Se excedió del límite disponible', Colors.black);
                            }
                            // Navigator.pushNamed(context, 'SeleccionaHorario');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffffb240),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffffb240).withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 12,
                                  offset: Offset(0, 8), // changes position of shadow
                                ),
                              ],
                            ),
                            height: ScreenUtil().setHeight(60),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setWidth(20),
                                ),
                                Text(
                                  'Continuar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(20),
                                  ),
                                ),
                                Spacer(),
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
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButton(),
                      Center(
                        child: Text('Sin resultados para la fecha ingresada'),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return ShowLoadding(
                w: double.infinity,
                h: double.infinity,
                colorText: Colors.yellow,
                fondo: Colors.black.withOpacity(0.3),
                active: true,
              );
            }
          }),
    );
  }

  Widget _cantidad(int cantidad, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(50),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  _controller.changeCatidad(-1, index);
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xffffb240), borderRadius: BorderRadius.circular(100)),
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      "-",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(36),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, snapshot) {
                    return Container(
                      color: Colors.white,
                      height: double.infinity,
                      child: Center(
                        child: Text(
                          _controller.array[index].toString(),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF606060),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  _controller.changeCatidad(1, index);
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xffffb240), borderRadius: BorderRadius.circular(100)),
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(36),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TarifasController extends ChangeNotifier {
  var array;

  void changeArray(var dato) {
    array = dato;
    notifyListeners();
  }

  void changeCatidad(int cantidad, int index) {
    if (cantidad > 0) {
      array[index]++;
    } else {
      if (array[index] > 1) {
        array[index]--;
      } else {
        array[index] = 0;
      }
    }
    print('dato actualizado index : $index, cantida ${array[index]}');

    notifyListeners();
  }
}
