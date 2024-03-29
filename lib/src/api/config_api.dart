import 'dart:convert';
import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/cuentos_database.dart';
import 'package:dicertur_quistococha/database/galeria_database.dart';
import 'package:dicertur_quistococha/database/servicio_database.dart';
import 'package:dicertur_quistococha/database/souvenir_database.dart';
import 'package:dicertur_quistococha/src/models/cuentos_model.dart';
import 'package:dicertur_quistococha/src/models/galeria_model.dart';
import 'package:dicertur_quistococha/src/models/servicios_model.dart';
import 'package:dicertur_quistococha/src/models/souvenir_model.dart';
import 'package:dicertur_quistococha/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class ConfigApi {
  final cuentosDatabase = CuentosDatabase();
  final servicioDatabase = ServicioDatabase();
  final galeriaDatabase = GaleriaDatabase();
  final souvenirDatabase = SouvenirDatabase();
  Future<bool> obtenerConfig() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Login/config_inicial');

      bool ret = false;

      final resp = await http.post(
        url,
        body: {
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);

      StorageManager.saveData('versionApp', decodedData['version'].toString());

      if (decodedData['cuentos'].length > 0) {
        for (var i = 0; i < decodedData['cuentos'].length; i++) {
          CuentosModel cuentosModel = CuentosModel();

          cuentosModel.idCuento = decodedData['cuentos'][i]['id_cuento'];
          cuentosModel.cuentoTitulo = decodedData['cuentos'][i]['cuento_titulo'];
          cuentosModel.cuentoDetalle = decodedData['cuentos'][i]['cuento_detalle'];
          cuentosModel.cuentoImagen = decodedData['cuentos'][i]['cuento_imagen'];
          cuentosModel.cuentoEstado = decodedData['cuentos'][i]['cuento_estado'];
          await cuentosDatabase.insertarCuentos(cuentosModel);
        }
      }

      if (decodedData['galeria'].length > 0) {
        for (var i = 0; i < decodedData['galeria'].length; i++) {
          GaleriaModel galeriaModel = GaleriaModel();

          galeriaModel.idGaleria = decodedData['galeria'][i]['id_galeria'];
          galeriaModel.galeriaFoto = decodedData['galeria'][i]['galeria_foto'];
          galeriaModel.galeriaEstado = decodedData['galeria'][i]['galeria_estado'];
          await galeriaDatabase.insertarGaleria(galeriaModel);
        }
      }

      if (decodedData['servicios'].length > 0) {
        for (var x = 0; x < decodedData['servicios'].length; x++) {
          ServicioModel servicioModel = ServicioModel();

          servicioModel.idServicio = decodedData['servicios'][x]['id_servicio'];
          servicioModel.servicioTitulo = decodedData['servicios'][x]['servicio_titulo'];
          servicioModel.servicioDetalle = decodedData['servicios'][x]['servicio_detalle'];
          servicioModel.servicioImagen = decodedData['servicios'][x]['servicio_imagen'];
          servicioModel.servicioPrecio = decodedData['servicios'][x]['servicio_precio'];
          servicioModel.servicioEstado = decodedData['servicios'][x]['servicio_estado'];
          servicioModel.servicioTipo = decodedData['servicios'][x]['servicio_tipo'];
          await servicioDatabase.insertarServicio(servicioModel);
        }
      }

      if (decodedData['productos'].length > 0) {
        for (var x = 0; x < decodedData['productos'].length; x++) {
          SourvenirModel sourvenirModel = SourvenirModel();

          sourvenirModel.idProduct = decodedData['productos'][x]['id_producto'];
          sourvenirModel.productTitle = decodedData['productos'][x]['producto_titulo'];
          sourvenirModel.productDetail = decodedData['productos'][x]['producto_detalle'];
          sourvenirModel.productImagen = decodedData['productos'][x]['producto_imagen'];
          sourvenirModel.productPrecio = decodedData['productos'][x]['producto_precio'];
          sourvenirModel.productEstado = decodedData['productos'][x]['producto_estado'];
          await souvenirDatabase.insertarSouvenir(sourvenirModel);
        }
      }

      return ret;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
}
