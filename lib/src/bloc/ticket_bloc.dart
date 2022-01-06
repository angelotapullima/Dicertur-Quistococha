import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:dicertur_quistococha/database/ticket_database.dart';
import 'package:dicertur_quistococha/src/api/ticket_api.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:rxdart/rxdart.dart';

class TicketBloc {
  final ticketApi = TicketApi();
  final ticketDatabase = TicketDatabase();
  final _ticketController = BehaviorSubject<List<TicketModel>>();
  Stream<List<TicketModel>> get ticketStream => _ticketController.stream;

  dispose() {
    _ticketController.close();
  }

  void getTicketsForUser(String estado) async {
    String? idUser = await StorageManager.readData('idUser');

    _ticketController.sink.add(await ticketDatabase.getTicketsForUser(idUser!, estado));
    await ticketApi.getTicketsAPi();
    _ticketController.sink.add(await ticketDatabase.getTicketsForUser(idUser, estado));
  }
}
