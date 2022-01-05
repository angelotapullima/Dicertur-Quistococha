/* import 'package:capitan_flutter_remake_remake/src/bloc/provider_bloc.dart';
import 'package:capitan_flutter_remake_remake/src/models/solicitud_reserva_model.dart';
import 'package:capitan_flutter_remake_remake/src/utils/WidgetCargandp.dart';
import 'package:flutter/material.dart';

class NotificacionReservaPage extends StatelessWidget {
  final String idReserva;
  const NotificacionReservaPage({Key key, @required this.idReserva}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solicitudesReservaBloc = ProviderBloc.solicitudesReserva(context);
    solicitudesReservaBloc.obtenerSolicitudReservaPorId(idReserva);
    return StreamBuilder(
        stream: solicitudesReservaBloc.solicitudReservaStream,
        builder: (context, AsyncSnapshot<List<SolicitudReservaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return Scaffold(
                body: Center(
                  child: Text('Hay datos'),
                ),
              );
            } else {
              return Scaffold();
            }
          } else {
            return Scaffold(body: CargandoWidget());
          }
        });
  }
}
 */