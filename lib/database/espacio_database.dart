import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/espacio_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DocumentosDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarEspacio(EspacioModel espacioModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Espacio',
        espacioModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Espacio");
    }
  }

   /*
    Para documentos proveedores: Consultas en la tabla documentos_varios, donde documento_clase = 1 y id_tipo es el id del proveedor
    En adjuntos de solicitud de compras es igual, sólo que documento_clase = 3 y el id_tipo es el id de la solicitud de compra
    */
  Future<List<EspacioModel>> getEspacio(String idEvento) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<EspacioModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Espacio where idEvento = '$idEvento' ");

      if (maps.length > 0) list = EspacioModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Espacio");
      return [];
    }
  }
}
