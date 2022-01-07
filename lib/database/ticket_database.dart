import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:sqflite/sqlite_api.dart';

class TicketDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarTicket(TicketModel ticketModel) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Ticket',
        ticketModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("$e Error en la tabla Ticket");
    }
  }

  Future<List<TicketModel>> getTicketsForUser(String idUser,String estado) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<TicketModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Ticket where idUser = '$idUser' and ticketEstado = '$estado' ");

      if (maps.length > 0) list = TicketModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Ticket");
      return [];
    }
  }

  Future<List<TicketModel>> getTicketsForUserActivos(String idUser) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<TicketModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Ticket where idUser = '$idUser' and ticketEstado <> '2' ");

      if (maps.length > 0) list = TicketModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Ticket");
      return [];
    }
  }

  Future<List<TicketModel>> getTicketsForID(String idTicket) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<TicketModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Ticket where idTicket = '$idTicket' ");

      if (maps.length > 0) list = TicketModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Ticket");
      return [];
    }
  }
}
