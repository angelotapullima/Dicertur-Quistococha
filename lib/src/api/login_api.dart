import 'dart:convert';
import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  Future<ApiModel> login(String user, String pass) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Login/validar_sesion');

      final resp = await http.post(url, body: {
        'usuario_nickname': '$user',
        'usuario_contrasenha': '$pass',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      ApiModel loginModel = ApiModel();
      loginModel.code = code.toString();
      loginModel.message = decodedData['result']['message'];

      if (code == 1) {
        StorageManager.saveData('idUser', decodedData['data']['c_u']);
        StorageManager.saveData('idPerson', decodedData['data']['c_p']);
        StorageManager.saveData('userNickname', decodedData['data']['_n']);
        StorageManager.saveData('userEmail', decodedData['data']['u_e']);
        StorageManager.saveData('userImage', decodedData['data']['u_i']);
        StorageManager.saveData('personName', decodedData['data']['p_n']);
        StorageManager.saveData('personSurname', decodedData['data']['p_p']);
        StorageManager.saveData('idRoleUser', decodedData['data']['ru']);
        StorageManager.saveData('roleName', decodedData['data']['rn']);
        StorageManager.saveData('token', decodedData['data']['tn']);

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

  Future<ApiModel> loginEmail(String user) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Login/validar_sesion_email');

      final resp = await http.post(url, body: {
        'usuario_nickname': '$user',
        'usuario_contrasenha': '',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      ApiModel loginModel = ApiModel();
      loginModel.code = code.toString();
      loginModel.message = decodedData['result']['message'];

      if (code == 1) {
        print('code suscessfull');

        StorageManager.saveData('idUser', decodedData['data']['c_u']);
        StorageManager.saveData('idPerson', decodedData['data']['c_p']);
        StorageManager.saveData('userNickname', decodedData['data']['_n']);
        StorageManager.saveData('userEmail', decodedData['data']['u_e']);
        StorageManager.saveData('userImage', decodedData['data']['u_i']);
        StorageManager.saveData('personName', decodedData['data']['p_n']);
        StorageManager.saveData('personSurname', decodedData['data']['p_p']);
        StorageManager.saveData('idRoleUser', decodedData['data']['ru']);
        StorageManager.saveData('roleName', decodedData['data']['rn']);
        StorageManager.saveData('token', decodedData['data']['tn']);

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

  Future<ApiModel> registerUser(String nombre, String apellido, String email, String pass) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Login/guardar_usuario');

      final resp = await http.post(url, body: {
        'persona_nombre': '$nombre',
        'persona_apellido_paterno': '$apellido',
        'usuario_nickname': '$email',
        'id_rol': '4',
        'persona_telefono': '11111111',
        'usuario_contrasenha': '$pass',
        'usuario_email': '$email',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      ApiModel loginModel = ApiModel();
      loginModel.code = code.toString();
      loginModel.message = decodedData['result']['message'];

      if (code == 1) {
        return loginModel;
      } else if (code == 4 || code == 3) {
        showToast2('Este email ya esta asignado a otra cuenta', Colors.yellow);
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

class ApiModel {
  String? code;
  String? message;

  ApiModel({this.code, this.message});
}


/*

$ok_data = $this->validar->validar_parametro('persona_nombre', 'POST',true,$ok_data,100,'texto',0);
            $ok_data = $this->validar->validar_parametro('persona_apellido_paterno', 'POST',true,$ok_data,30,'texto',0);
            $ok_data = $this->validar->validar_parametro('persona_telefono', 'POST',true,$ok_data,15,'texto',0);
            $ok_data = $this->validar->validar_parametro('id_rol', 'POST',true,$ok_data,11,'numero',0);
            $ok_data = $this->validar->validar_parametro('usuario_nickname', 'POST',true,$ok_data,100,'texto',0);
            $ok_data = $this->validar->validar_parametro('usuario_contrasenha', 'POST',true,$ok_data,70,'texto',0);
            $ok_data = $this->validar->validar_parametro('usuario_email', 'POST',false,$ok_data,100,'email',0);
            
             */