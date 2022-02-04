 
import 'package:dicertur_quistococha/database/souvenir_database.dart';
import 'package:dicertur_quistococha/src/api/config_api.dart';
import 'package:dicertur_quistococha/src/models/souvenir_model.dart'; 
import 'package:rxdart/rxdart.dart';

class SouvenirBloc {
  final souvenirDatabase = SouvenirDatabase();
  final configApi = ConfigApi();

  final _souvenirController = BehaviorSubject<List<SourvenirModel>>();
  Stream<List<SourvenirModel>> get souvenirStream => _souvenirController.stream;

  dispose() {
    _souvenirController.close();
  }

  void getSouvenir() async {
    _souvenirController.sink.add(await souvenirDatabase.getSouvenirs());
    await configApi.obtenerConfig();
    _souvenirController.sink.add(await souvenirDatabase.getSouvenirs());
  }
}
