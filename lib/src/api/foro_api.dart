import 'dart:convert';

import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/foro_database.dart';
import 'package:dicertur_quistococha/src/api/login_api.dart';
import 'package:dicertur_quistococha/src/models/foro_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class ForoApi {
  final foroDatabase = ForoDatabase();
  Future<ApiModel> getForos() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Empresa/listar_foros');
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
            ForoModel foroModel = ForoModel();

            foroModel.idForo = decodedData["result"]['data'][i]['id_foro'];
            foroModel.idUsuario = decodedData["result"]['data'][i]['id_usuario'];
            foroModel.foroTitulo = decodedData["result"]['data'][i]['foro_titulo'];
            foroModel.foroDatetime = decodedData["result"]['data'][i]['foro_datetime'];
            foroModel.foroDetalle = decodedData["result"]['data'][i]['foro_detalle'];
            foroModel.personaName = decodedData["result"]['data'][i]['persona_nombre'];
            foroModel.personaSurName = decodedData["result"]['data'][i]['persona_apellido_paterno'];
            foroModel.foroImagen = decodedData["result"]['data'][i]['foro_foto'];
            foroModel.foroEstado = decodedData["result"]['data'][i]['foro_estado'];
            foroModel.usuarioImagen = decodedData["result"]['data'][i]['usuario_imagen'];
            await foroDatabase.insertarForo(foroModel);
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
