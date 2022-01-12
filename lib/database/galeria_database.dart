import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/galeria_model.dart'; 
import 'package:sqflite/sqlite_api.dart';

class GaleriaDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarGaleria(GaleriaModel cuentosModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Galeria',
        cuentosModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Galeria");
    }
  }

  Future<List<GaleriaModel>> getGaleria() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<GaleriaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Galeria where galeriaEstado = '1' ");

      if (maps.length > 0) list = GaleriaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Galeria");
      return [];
    }
  }
}
