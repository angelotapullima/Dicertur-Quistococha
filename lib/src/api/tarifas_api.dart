import 'dart:convert';

import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/models/espacio_model.dart';
import 'package:dicertur_quistococha/src/models/evento_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class TarifaApi {
  Future<ApiModel> login(String fecha) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Empresa/listar_tarifas_app');

      final resp = await http.post(url, body: {
        'fecha': '$fecha',
        'app': 'true',
        'tn': 'true',
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      ApiModel loginModel = ApiModel();
      loginModel.code = code.toString();

      if (code == 1) {
        if (decodedData['data'].length > 0) {
          for (var i = 0; i < decodedData['data'].length; i++) {
            EventoModel evento = EventoModel();

            evento.idEvento = decodedData['data'][i]['id_evento'];
            evento.eventoNombre = decodedData['data'][i]['evento_nombre'];
            evento.eventoFecha = decodedData['data'][i]['evento_fecha'];
            evento.eventoHora = decodedData['data'][i]['evento_hora'];
            evento.eventoDireccion = decodedData['data'][i]['evento_direccion'];
            evento.eventoEstado = decodedData['data'][i]['evento_estado'];


            EspacioModel espacioModel = EspacioModel();
            espacioModel.idEspacio = decodedData['data'][i]['id_espacio'];
            espacioModel.idEvento = decodedData['data'][i]['id_evento'];
            espacioModel.espacioNombre = decodedData['data'][i]['espacio_nombre'];
            espacioModel.espacioAforo = decodedData['data'][i]['espacio_aforo'];
            espacioModel.espacioEstado = decodedData['data'][i]['espacio_estado'];
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
