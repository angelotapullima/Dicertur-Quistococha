import 'dart:convert';

import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/src/models/ticket_url_api_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class TicketsApi {
  Future<TicketUrlApiModel> guardarTicket(
    String idEvento,
    String total,
    String detalle,
    String nombre,
    String telefono,
    String dni,
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
}
