import 'package:dicertur_quistococha/database/cuentos_database.dart';
import 'package:dicertur_quistococha/src/api/config_api.dart';
import 'package:dicertur_quistococha/src/models/cuentos_model.dart';
import 'package:rxdart/rxdart.dart';

class CuentosBloc {
  final cuentosDatabase = CuentosDatabase();
  final configApi = ConfigApi();

  final _cuentosController = BehaviorSubject<List<CuentosModel>>();
  Stream<List<CuentosModel>> get cuentosStream => _cuentosController.stream;

  dispose() {
    _cuentosController.close();
  }

  void getCuentos() async {
    _cuentosController.sink.add(await cuentosDatabase.getCuentos());
    await configApi.obtenerConfig();
    _cuentosController.sink.add(await cuentosDatabase.getCuentos());
  }
}
