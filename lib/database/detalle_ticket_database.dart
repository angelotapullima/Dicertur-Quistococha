import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/detalle_ticket_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DetalleTicketDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarDetalleTicket(DetalleTicketModel detalleTicket) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'DetalleTicket',
        detalleTicket.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla DetalleTicket");
    }
  }

  Future<List<DetalleTicketModel>> getDetalleTicketsForID(String idTicket) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<DetalleTicketModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM DetalleTicket where idTicket = '$idTicket' ");

      if (maps.length > 0) list = DetalleTicketModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla DetalleTicket");
      return [];
    }
  }
}
