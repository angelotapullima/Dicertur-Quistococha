import 'dart:convert';

import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/ticket_database.dart';

import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class TicketApi {
  final ticketDatabase = TicketDatabase();
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
            await ticketDatabase.insertarTicket(ticketModel);
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
}
