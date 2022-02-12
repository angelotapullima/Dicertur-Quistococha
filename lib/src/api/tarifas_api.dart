import 'dart:convert';

import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/espacio_database.dart';
import 'package:dicertur_quistococha/database/evento_database.dart';
import 'package:dicertur_quistococha/database/tarifa_database.dart';
import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/models/espacio_model.dart';
import 'package:dicertur_quistococha/src/models/evento_model.dart';
import 'package:dicertur_quistococha/src/models/tarifa_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class TarifaApi {
  final espacioDatabase = EspacioDatabase();
  final eventoDatabase = EventoDatabase();
  final tarifaDatabase = TarifaDatabase();
  Future<ApiModel> obtenerTarifas(String fecha) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Empresa/listar_tarifas_app');
      String? token = await StorageManager.readData('token');

      final resp = await http.post(url, body: {
        'fecha': '$fecha',
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
            EventoModel evento = EventoModel();

            evento.idEvento = decodedData["result"]['data'][i]['id_evento'];
            evento.eventoNombre = decodedData["result"]['data'][i]['evento_nombre'];
            evento.eventoFecha = decodedData["result"]['data'][i]['evento_fecha'];
            evento.eventoHora = decodedData["result"]['data'][i]['evento_hora'];
            evento.eventoDireccion = decodedData["result"]['data'][i]['evento_direccion'];
            evento.eventoEstado = decodedData["result"]['data'][i]['evento_estado'];
            await eventoDatabase.insertarEvento(evento);

            EspacioModel espacioModel = EspacioModel();
            espacioModel.idEspacio = decodedData["result"]['data'][i]['id_espacio'];
            espacioModel.idEvento = decodedData["result"]['data'][i]['id_evento'];
            espacioModel.espacioNombre = decodedData["result"]['data'][i]['espacio_nombre'];
            espacioModel.espacioAforo = decodedData["result"]['data'][i]['espacio_aforo'];
            espacioModel.espacioStock = decodedData["result"]['data'][i]['espacio_stock'];
            espacioModel.espacioEstado = decodedData["result"]['data'][i]['espacio_estado'];
            await espacioDatabase.insertarEspacio(espacioModel);

            if (decodedData["result"]['data'][i]['tarifas'].length > 0) {
              for (var x = 0; x < decodedData["result"]['data'][i]['tarifas'].length; x++) {
                var tarifa = decodedData["result"]['data'][i]['tarifas'][x];

                TarifaModel tarifaModel = TarifaModel();
                tarifaModel.idTarifa = tarifa['id_tarifa'];
                tarifaModel.idEspacio = tarifa['id_espacio'];
                tarifaModel.tarifaNombre = tarifa['tarifa_nombre'];
                tarifaModel.tarifaPrecio = tarifa['tarifa_precio'];
                tarifaModel.tarifaEstado = tarifa['tarifa_estado'];
                await tarifaDatabase.insertarTarifa(tarifaModel);
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
}
