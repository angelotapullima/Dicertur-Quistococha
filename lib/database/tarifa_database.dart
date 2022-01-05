import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/evento_model.dart';
import 'package:dicertur_quistococha/src/models/tarifa_model.dart';
import 'package:sqflite/sqlite_api.dart';

class TarifaDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarTarifa(TarifaModel tarifaModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Tarifas',
        tarifaModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Evento");
    }
  }

  /*
    Para documentos proveedores: Consultas en la tabla documentos_varios, donde documento_clase = 1 y id_tipo es el id del proveedor
    En adjuntos de solicitud de compras es igual, sólo que documento_clase = 3 y el id_tipo es el id de la solicitud de compra
    */
  Future<List<TarifaModel>> getTarifaForIdEspacio(String idEspacio) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<TarifaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Tarifas where idEspacio = '$idEspacio' ");

      if (maps.length > 0) list = TarifaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Evento");
      return [];
    }
  }
}
