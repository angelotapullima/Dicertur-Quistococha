import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/detalle_ticket_database.dart';
import 'package:dicertur_quistococha/database/ticket_database.dart';
import 'package:dicertur_quistococha/src/api/ticket_api.dart';
import 'package:dicertur_quistococha/src/models/detalle_ticket_model.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:rxdart/rxdart.dart';

class TicketBloc {
  final ticketApi = TicketApi();
  final ticketDatabase = TicketDatabase();
  final detalleTicketDatabase = DetalleTicketDatabase();
  final _ticketController = BehaviorSubject<List<TicketModel>>();
  final _ticketIdController = BehaviorSubject<List<TicketModel>>();
  Stream<List<TicketModel>> get ticketStream => _ticketController.stream;
  Stream<List<TicketModel>> get ticketIdStream => _ticketIdController.stream;

  dispose() {
    _ticketController.close();
    _ticketIdController.close();
  }

  void getTicketsForUser(String estado) async {
    String? idUser = await StorageManager.readData('idUser');

    if (estado == '2') {
      _ticketController.sink.add(await ticketDatabase.getTicketsForUser(idUser!, estado));
      await ticketApi.getTicketsAPi();
      _ticketController.sink.add(await ticketDatabase.getTicketsForUser(idUser, estado));
    } else {
      _ticketController.sink.add(await ticketDatabase.getTicketsForUser(idUser!, estado));
      await ticketApi.getTicketsAPi();
      _ticketController.sink.add(await ticketDatabase.getTicketsForUser(idUser, estado));
    }
  }

  void getTicketsForID(String id) async {
    _ticketIdController.sink.add(await ticketDetails(id));
    await ticketApi.getTicketsForIdApi(id);
    _ticketIdController.sink.add(await ticketDetails(id));
  }

  Future<List<TicketModel>> ticketDetails(String id) async {
    final List<TicketModel> listFinal = [];
    final list = await ticketDatabase.getTicketsForID(id);

    if (list.length > 0) {
      for (var i = 0; i < list.length; i++) {
        TicketModel ticketModel = TicketModel();
        ticketModel.idTicket = list[i].idTicket;
        ticketModel.idUser = list[i].idUser;
        ticketModel.idEvento = list[i].idEvento;
        ticketModel.ticketTotal = list[i].ticketTotal;
        ticketModel.ticketDateTime = list[i].ticketDateTime;
        ticketModel.ticketTipoPago = list[i].ticketTipoPago;
        ticketModel.ticketCodigoApp = list[i].ticketCodigoApp;
        ticketModel.ticketEstado = list[i].ticketEstado;
        ticketModel.eventoFecha = list[i].eventoFecha;
        ticketModel.clienteNombre = list[i].clienteNombre;
        ticketModel.clienteTelefono = list[i].clienteTelefono;
        ticketModel.clienteDni = list[i].clienteDni;
        ticketModel.eventoHoraFin = list[i].eventoHoraFin;
        ticketModel.eventoHoraInicio = list[i].eventoHoraInicio;

        final detalleData = await detalleTicketDatabase.getDetalleTicketsForID(list[i].idTicket.toString());

        final List<DetalleTicketModel> listDetalleFinal = [];
        if (detalleData.length > 0) {
          for (var x = 0; x < detalleData.length; x++) {
            DetalleTicketModel detalleTicketModel = DetalleTicketModel();

            detalleTicketModel.idDetalleTicket = detalleData[x].idDetalleTicket;
            detalleTicketModel.idTicket = detalleData[x].idTicket;
            detalleTicketModel.tarifaNombre = detalleData[x].tarifaNombre;
            detalleTicketModel.tarifaPrecio = detalleData[x].tarifaPrecio;
            detalleTicketModel.tarifaDetalleCantidad = detalleData[x].tarifaDetalleCantidad;
            detalleTicketModel.tarifaDetalleSubTotal = detalleData[x].tarifaDetalleSubTotal;
            detalleTicketModel.tarifaDetalleEstado = detalleData[x].tarifaDetalleEstado;
            listDetalleFinal.add(detalleTicketModel);
          }
        }
        ticketModel.detalle = listDetalleFinal;

        listFinal.add(ticketModel);
        print('gdgf');
      }
    }
    return listFinal;
  }
}
