import 'dart:convert';
import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/bloc/data_user.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class CuentaApi {
  Future<ApiModel> editAccount(UserModel user) async {
    final ApiModel api = ApiModel();
    try {
      final url = Uri.parse('$apiBaseURL/api/empresa/guardar_edicion_persona');
      String? token = await StorageManager.readData('token');

      final resp = await http.post(
        url,
        body: {
          'app': 'true',
          'tn': token,
          'id_persona': '${user.idPerson}',
          'persona_nombre': '${user.personName}',
          'persona_apellido_paterno': '${user.personSurnameP}',
          'persona_apellido_materno': '${user.personSurnameM}',
          'persona_nacimiento': '${user.nacimiento}',
          'persona_telefono': '${user.telefono}',
        },
      );

      final decodedData = json.decode(resp.body);

      int code = decodedData["result"]["code"];

      api.code = code.toString();
      api.message = decodedData["result"]["message"];

      if (code == 1) {
        StorageManager.saveData('personName', decodedData['result']['persona']['persona_nombre']);
        StorageManager.saveData('personSurname',
            "${decodedData['result']['persona']['persona_apellido_paterno']} ${_verificarNull(decodedData['result']['persona']['persona_apellido_materno'])}");
        StorageManager.saveData('personSurnameP', decodedData['result']['persona']['persona_apellido_paterno']);
        StorageManager.saveData('personSurnameM', _verificarNull(decodedData['result']['persona']['persona_apellido_materno']));
        StorageManager.saveData('telefono', _verificarNull(decodedData['result']['persona']['persona_telefono']));
        StorageManager.saveData('nacimiento', _verificarNull(decodedData['result']['persona']['persona_nacimiento']));
      }

      return api;
    } catch (e) {
      api.code = '2';
      api.message = 'Ocurrió un error';
      return api;
    }
  }

  Future<ApiModel> changePassword(String password) async {
    final ApiModel api = ApiModel();
    try {
      final url = Uri.parse('$apiBaseURL/api/empresa/restablecer_contrasenha');
      String? token = await StorageManager.readData('token');

      final resp = await http.post(
        url,
        body: {
          'app': 'true',
          'tn': token,
          'contrasenha': password,
        },
      );

      final decodedData = json.decode(resp.body);
      print(decodedData);

      int code = decodedData["result"]["code"];

      api.code = code.toString();
      api.message = decodedData["result"]["message"];

      if (code == 1) {
        StorageManager.saveData('token', decodedData['result']['tn']);
      }

      return api;
    } catch (e) {
      api.code = '2';
      api.message = 'Ocurrió un error';
      return api;
    }
  }

  _verificarNull(var data) {
    if (data != null) {
      return data;
    } else {
      return '';
    }
  }
}
