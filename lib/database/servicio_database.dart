import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/servicios_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ServicioDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarServicio(ServicioModel cuentosModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Servicios',
        cuentosModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Servicios");
    }
  }

  Future<List<ServicioModel>> getServicio() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ServicioModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Servicios where servicioEstado = '1' ");

      if (maps.length > 0) list = ServicioModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Servicios");
      return [];
    }
  }
  Future<List<ServicioModel>> getServiceForId(String idService) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<ServicioModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Servicios where servicioEstado = '1' and idServicio = '$idService' ");

      if (maps.length > 0) list = ServicioModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Servicios");
      return [];
    }
  }
}
