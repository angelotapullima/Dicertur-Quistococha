import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/foro_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ForoDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarForo(ForoModel foroModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Foro',
        foroModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Foro");
    }
  }

  Future<List<ForoModel>> getForo() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ForoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Foro where foroEstado = '1' ORDER BY cast(idForo as int) DESC");

      if (maps.length > 0) list = ForoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Foro");
      return [];
    }
  }
}
