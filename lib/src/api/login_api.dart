import 'dart:convert';
import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
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

        /*  prefs.idUser = decodedData['data']['c_u'];
        //prefs.idPerson = decodedData['data']['c_p'];

        //variable que indica si tienes permiso para crear un torneo
        //u_torneo = 0 => 'no tiene permisos' ,u_torneo = 1=> 'si tiene permisos'
        prefs.validarCrearTorneo = decodedData['data']['u_torneo'];

        prefs.userNickname = decodedData['data']['_n'];
        prefs.userEmail = decodedData['data']['u_e'];
        prefs.userEmailValidateCode = decodedData['data']['u_ve'];
        prefs.image = decodedData['data']['u_i'];
        prefs.personName = decodedData['data']['p_n'];
        prefs.personSurname = '${decodedData['data']['p_p']} ${decodedData['data']['p_m']}';
        prefs.apellidoPaterno = decodedData['data']['p_p'];
        prefs.apellidoMaterno = decodedData['data']['p_m'];
        prefs.personAddress = decodedData['data']['p_d'];
        prefs.personGenre = decodedData['data']['p_s'];
        prefs.personNacionalidad = decodedData['data']['p_na'];
        prefs.fechaCreacion = decodedData['data']['u_crea'];
        prefs.idRol = decodedData['data']['ru'];
        prefs.rolNombre = decodedData['data']['rn'];
        prefs.ciudadID = decodedData['data']['u_u'];
        prefs.userPosicion = decodedData['data']['u_po'];
        prefs.userHabilidad = decodedData['data']['u_ha'];
        prefs.userNum = decodedData['data']['u_nu'];
        prefs.token = decodedData['data']['tn'];
        prefs.tokenFirebase = decodedData['data']['u_tk'];
        //prefs.tieneNegocio = decodedData['data']['u_tn'];
        prefs.codigoUser = decodedData['data']['u_cod'];
        prefs.personNumberPhone = (decodedData['data']['p_t'] == null) ? '' : decodedData['data']['p_t'];
        prefs.personBirth = (decodedData['data']['p_nac'] == null) ? '' : decodedData['data']['p_nac'];
        prefs.password = pass; */

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

        /*  prefs.idUser = decodedData['data']['c_u'];
        //prefs.idPerson = decodedData['data']['c_p'];

        //variable que indica si tienes permiso para crear un torneo
        //u_torneo = 0 => 'no tiene permisos' ,u_torneo = 1=> 'si tiene permisos'
        prefs.validarCrearTorneo = decodedData['data']['u_torneo'];

        prefs.userNickname = decodedData['data']['_n'];
        prefs.userEmail = decodedData['data']['u_e'];
        prefs.userEmailValidateCode = decodedData['data']['u_ve'];
        prefs.image = decodedData['data']['u_i'];
        prefs.personName = decodedData['data']['p_n'];
        prefs.personSurname = '${decodedData['data']['p_p']} ${decodedData['data']['p_m']}';
        prefs.apellidoPaterno = decodedData['data']['p_p'];
        prefs.apellidoMaterno = decodedData['data']['p_m'];
        prefs.personAddress = decodedData['data']['p_d'];
        prefs.personGenre = decodedData['data']['p_s'];
        prefs.personNacionalidad = decodedData['data']['p_na'];
        prefs.fechaCreacion = decodedData['data']['u_crea'];
        prefs.idRol = decodedData['data']['ru'];
        prefs.rolNombre = decodedData['data']['rn'];
        prefs.ciudadID = decodedData['data']['u_u'];
        prefs.userPosicion = decodedData['data']['u_po'];
        prefs.userHabilidad = decodedData['data']['u_ha'];
        prefs.userNum = decodedData['data']['u_nu'];
        prefs.token = decodedData['data']['tn'];
        prefs.tokenFirebase = decodedData['data']['u_tk'];
        //prefs.tieneNegocio = decodedData['data']['u_tn'];
        prefs.codigoUser = decodedData['data']['u_cod'];
        prefs.personNumberPhone = (decodedData['data']['p_t'] == null) ? '' : decodedData['data']['p_t'];
        prefs.personBirth = (decodedData['data']['p_nac'] == null) ? '' : decodedData['data']['p_nac'];
        //prefs.password = pass; */

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
/* 
  Future<int> registerUser(String user, String pass) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Inicio/new');

      final userRegisterDatabase = UserRegisterDatabase();

      final listDatos = await userRegisterDatabase.obtenerUserg();

      if (listDatos.length <= 0) {
        return 2;
      }

      final resp = await http.post(
        url,
        body: {
          'person_name': '${listDatos[listDatos.length - 1].nombre}',
          'person_surname': '${listDatos[listDatos.length - 1].apellidoPaterno}',
          'person_surname2': '${listDatos[listDatos.length - 1].apellidoMaterno}',
          'person_birth': '${listDatos[listDatos.length - 1].nacimiento}',
          'user_image': '',
          'person_genre': '${listDatos[listDatos.length - 1].sexo}',
          'user_nickname': '$user',
          'user_password': '$pass',
          'user_email': '${listDatos[listDatos.length - 1].email}',
          'user_habilidad': '${listDatos[listDatos.length - 1].habilidad}',
          'user_posicion': '${listDatos[listDatos.length - 1].posicion}',
          'user_num': '${listDatos[listDatos.length - 1].nfav}',
          'person_number_phone': '${listDatos[listDatos.length - 1].telefono}',
          'ubigeo_id': '${listDatos[listDatos.length - 1].idCiudad}',
          'app': 'true'
        },
      );

      final decodedData = json.decode(resp.body);
      print(decodedData);

      //final int code = decodedData['result']['code'];

      if (decodedData == 1) {
        return 10;
      } else {
        return decodedData['result']['code'];
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 0;
    }
  }

  Future<int> registerNewUser(UserRegisterModel datos, String user, String pass) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Inicio/new2');

      final resp = await http.post(
        url,
        body: {
          'person_name': '${datos.nombre}',
          'person_surname': '${datos.apellidoPaterno}',
          'person_birth': '${datos.nacimiento}',
          'user_nickname': '$user',
          'user_password': '$pass',
          'user_email': '$user',
          'person_number_phone': '${datos.telefono}',
          'ubigeo_id': '${datos.idCiudad}',
          'app': 'true'
          
        },
      );

      final decodedData = json.decode(resp.body);
      print(decodedData);

      //final int code = decodedData['result']['code'];

      if (decodedData == 1) {
        return 10;
      } else {
        return decodedData['result']['code'];
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 0;
    }
  }

 */
}

class ApiModel {
  String? code;
  String? message;

  ApiModel({this.code, this.message});
}
