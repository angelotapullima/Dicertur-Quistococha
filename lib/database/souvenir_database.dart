import 'package:dicertur_quistococha/database/databd_config.dart'; 
import 'package:dicertur_quistococha/src/models/souvenir_model.dart';
import 'package:sqflite/sqlite_api.dart';

class SouvenirDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarSouvenir(SourvenirModel sourvenirModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Souvenir',
        sourvenirModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Souvenir");
    }
  }

  Future<List<SourvenirModel>> getSouvenirs() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SourvenirModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Souvenir where productEstado = '1' ");

      if (maps.length > 0) list = SourvenirModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Souvenir");
      return [];
    }
  }
  Future<List<SourvenirModel>> getSouvenirsForId(String idProduct) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<SourvenirModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Souvenir where productEstado = '1' and idProduct = '$idProduct' ");

      if (maps.length > 0) list = SourvenirModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Souvenir");
      return [];
    }
  }
}
