import 'dart:convert';

import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/detalle_ticket_database.dart';
import 'package:dicertur_quistococha/database/ticket_database.dart';

import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/models/detalle_ticket_model.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:dicertur_quistococha/src/models/ticket_url_api_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class TicketApi {
  final ticketDatabase = TicketDatabase();
  final detalleTicketDatabase = DetalleTicketDatabase();
  Future<ApiModel> getTicketsAPi() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Empresa/listar_tickets_app');
      String? token = await StorageManager.readData('token');

      final resp = await http.post(url, body: {
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      ApiModel loginModel = ApiModel();
      loginModel.code = code.toString();

      if (code == 1) {
        if (decodedData["result"]['data'].length > 0) {
          for (var i = 0; i < decodedData["result"]['data'].length; i++) {
            TicketModel ticketModel = TicketModel();
            ticketModel.idTicket = decodedData['result']['data'][i]['id_ticket'];
            ticketModel.idUser = decodedData['result']['data'][i]['id_usuario'];
            ticketModel.idEvento = decodedData['result']['data'][i]['id_evento'];
            ticketModel.ticketTotal = decodedData['result']['data'][i]['ticket_total'];
            ticketModel.ticketDateTime = decodedData['result']['data'][i]['ticket_datetime'];
            ticketModel.ticketTipoPago = decodedData['result']['data'][i]['ticket_tipo_pago'];
            ticketModel.ticketCodigoApp = decodedData['result']['data'][i]['ticket_codigo_app'];
            ticketModel.ticketEstado = decodedData['result']['data'][i]['ticket_estado'];
            ticketModel.eventoFecha = decodedData['result']['data'][i]['evento_fecha'];
            ticketModel.clienteNombre = decodedData['result']['data'][i]['cliente_nombre'];
            ticketModel.clienteTelefono = decodedData['result']['data'][i]['cliente_telefono'];
            ticketModel.clienteDni = decodedData['result']['data'][i]['cliente_numero'];

            final horsFormat = decodedData['result']['data'][i]['evento_hora']!.split("-");
            var horaInicio = horsFormat[0].trim();
            var horaFin = horsFormat[1].trim();
            ticketModel.eventoHoraInicio = horaInicio;
            ticketModel.eventoHoraFin = horaFin;

            await ticketDatabase.insertarTicket(ticketModel);

            if (decodedData["result"]['data'][i]['detalle'].length > 0) {
              for (var x = 0; x < decodedData["result"]['data'][i]['detalle'].length; x++) {
                DetalleTicketModel detalleTicketModel = DetalleTicketModel();

                detalleTicketModel.idDetalleTicket = decodedData["result"]['data'][i]['detalle'][x]['id_ticket_detalle'];
                detalleTicketModel.idTicket = decodedData["result"]['data'][i]['detalle'][x]['id_ticket'];
                detalleTicketModel.tarifaNombre = decodedData["result"]['data'][i]['detalle'][x]['tarifa_nombre'];
                detalleTicketModel.tarifaPrecio = decodedData["result"]['data'][i]['detalle'][x]['tarifa_precio'];
                detalleTicketModel.tarifaDetalleCantidad = decodedData["result"]['data'][i]['detalle'][x]['ticket_detalle_cantidad'];
                detalleTicketModel.tarifaDetalleSubTotal = decodedData["result"]['data'][i]['detalle'][x]['ticket_detalle_subtotal'];
                detalleTicketModel.tarifaDetalleEstado = decodedData["result"]['data'][i]['detalle'][x]['ticket_detalle_estado'];
                detalleTicketModel.idTarifa = decodedData["result"]['data'][i]['detalle'][x]['id_tarifa'];

                await detalleTicketDatabase.insertarDetalleTicket(detalleTicketModel);
              }
            }
          }
        }

        return loginModel;
      } else {
        return loginModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      ApiModel loginModel = ApiModel();
      loginModel.code = '2';
      loginModel.message = 'Error en la petición';
      return loginModel;
    }
  }

  Future<ApiModel> getTicketsForIdApi(String id) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Empresa/listar_ticket_id_app');
      String? token = await StorageManager.readData('token');

      final resp = await http.post(url, body: {
        'app': 'true',
        'tn': token,
        'id_ticket': id,
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      ApiModel loginModel = ApiModel();
      loginModel.code = code.toString();

      if (code == 1) {
        TicketModel ticketModel = TicketModel();
        ticketModel.idTicket = decodedData['result']['data']['id_ticket'];
        ticketModel.idUser = decodedData['result']['data']['id_usuario'];
        ticketModel.idEvento = decodedData['result']['data']['id_evento'];
        ticketModel.ticketTotal = decodedData['result']['data']['ticket_total'];
        ticketModel.ticketDateTime = decodedData['result']['data']['ticket_datetime'];
        ticketModel.ticketTipoPago = decodedData['result']['data']['ticket_tipo_pago'];
        ticketModel.ticketCodigoApp = decodedData['result']['data']['ticket_codigo_app'];
        ticketModel.ticketEstado = decodedData['result']['data']['ticket_estado'];
        ticketModel.eventoFecha = decodedData['result']['data']['evento_fecha'];
        ticketModel.clienteNombre = decodedData['result']['data']['cliente_nombre'];
        ticketModel.clienteTelefono = decodedData['result']['data']['cliente_telefono'];
        ticketModel.clienteDni = decodedData['result']['data']['cliente_numero'];

        final horsFormat = decodedData['result']['data']['evento_hora']!.split("-");
        var horaInicio = horsFormat[0].trim();
        var horaFin = horsFormat[1].trim();
        ticketModel.eventoHoraInicio = horaInicio;
        ticketModel.eventoHoraFin = horaFin;

        await ticketDatabase.insertarTicket(ticketModel);

        if (decodedData["result"]['data']['detalle'].length > 0) {
          for (var x = 0; x < decodedData["result"]['data']['detalle'].length; x++) {
            DetalleTicketModel detalleTicketModel = DetalleTicketModel();

            detalleTicketModel.idDetalleTicket = decodedData["result"]['data']['detalle'][x]['id_ticket_detalle'];
            detalleTicketModel.idTicket = decodedData["result"]['data']['detalle'][x]['id_ticket'];
            detalleTicketModel.tarifaNombre = decodedData["result"]['data']['detalle'][x]['tarifa_nombre'];
            detalleTicketModel.tarifaPrecio = decodedData["result"]['data']['detalle'][x]['tarifa_precio'];
            detalleTicketModel.tarifaDetalleCantidad = decodedData["result"]['data']['detalle'][x]['ticket_detalle_cantidad'];
            detalleTicketModel.tarifaDetalleSubTotal = decodedData["result"]['data']['detalle'][x]['ticket_detalle_subtotal'];
            detalleTicketModel.tarifaDetalleEstado = decodedData["result"]['data']['detalle'][x]['ticket_detalle_estado'];
            detalleTicketModel.idTarifa = decodedData["result"]['data']['detalle'][x]['id_tarifa'];
            await detalleTicketDatabase.insertarDetalleTicket(detalleTicketModel);
          }
        }

        return loginModel;
      } else {
        return loginModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      ApiModel loginModel = ApiModel();
      loginModel.code = '2';
      loginModel.message = 'Error en la petición';
      return loginModel;
    }
  }

  Future<TicketUrlApiModel> guardarTicket(
    String idEvento,
    String total,
    String detalle,
    String nombre,
    String telefono,
    String dni,
    String idTipoDocumento,
    String domicilio,
    String tipoVenta,
  ) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Empresa/guardar_ticket');
      String? token = await StorageManager.readData('token');

      final resp = await http.post(url, body: {
        'nombre': nombre,
        'id_evento': idEvento,
        'telefono': telefono,
        'dni': dni,
        'total': total,
        'tipo_pago': '1',
        'detalle': detalle,
        'id_tipodocumento': idTipoDocumento,
        'tipo_venta': tipoVenta,
        'domicilio': domicilio,
        'app': 'true',
        'tn': token,
      });

      final decodedData = json.decode(resp.body);
      print(decodedData);

      final int code = decodedData['result']['code'];
      TicketUrlApiModel apiModel = TicketUrlApiModel();
      apiModel.code = code.toString();

      if (code == 1) {
        apiModel.idTicket = decodedData['result']['id_ticket'];
        apiModel.estado = decodedData['result']['pago_online']['estado'];
        apiModel.url = decodedData['result']['pago_online']['link'];
        apiModel.message = decodedData['result']['pago_online']['mensaje'];
      }

      return apiModel;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      TicketUrlApiModel apiModel = TicketUrlApiModel();
      apiModel.code = '2';
      apiModel.message = 'Error en la petición';
      return apiModel;
    }
  }

  Future<ApiModel> cobrarTicket(String idTicket, String detalle) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Empresa/cobrar_ticket');
      String? token = await StorageManager.readData('token');

      final resp = await http.post(url, body: {
        'app': 'true',
        'tn': token,
        'id_ticket': idTicket,
        'detalle': detalle,
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      ApiModel loginModel = ApiModel();
      loginModel.code = code.toString();

      if (code == 1) {
        return loginModel;
      } else {
        return loginModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      ApiModel loginModel = ApiModel();
      loginModel.code = '2';
      loginModel.message = 'Error en la petición';
      return loginModel;
    }
  }
}
