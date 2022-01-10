import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/cuentos_model.dart';
import 'package:sqflite/sqlite_api.dart';

class CuentosDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarCuentos(CuentosModel cuentosModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Cuentos',
        cuentosModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Cuentos");
    }
  }

  Future<List<CuentosModel>> getCuentos() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<CuentosModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Cuentos where cuentoEstado = '1' ");

      if (maps.length > 0) list = CuentosModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Cuentos");
      return [];
    }
  }
}
