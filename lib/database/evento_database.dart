import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/evento_model.dart';
import 'package:sqflite/sqlite_api.dart';

class EventoDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarEvento(EventoModel eventoModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Evento',
        eventoModel.toJson(),
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
  Future<List<EventoModel>> getEvento() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<EventoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Evento");

      if (maps.length > 0) list = EventoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Evento");
      return [];
    }
  }

  Future<List<EventoModel>> getEventoPorFecha(String fecha) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<EventoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Evento WHERE eventoFecha='$fecha'");

      if (maps.length > 0) list = EventoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Evento");
      return [];
    }
  }




  deleteEvento() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Evento");

    return res;
  }
}
