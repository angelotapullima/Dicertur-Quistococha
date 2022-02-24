import 'package:dicertur_quistococha/database/servicio_database.dart';
import 'package:dicertur_quistococha/src/api/config_api.dart';
import 'package:dicertur_quistococha/src/models/servicios_model.dart';
import 'package:rxdart/rxdart.dart';

class ServicioBloc {
  final servicioDatabase = ServicioDatabase();
  final configApi = ConfigApi();

  final _servicioController = BehaviorSubject<List<ServicioModel>>();
  Stream<List<ServicioModel>> get servicioStream => _servicioController.stream;

  final _servicioProductController = BehaviorSubject<List<ServicioModel>>();
  Stream<List<ServicioModel>> get servicioProductStream => _servicioProductController.stream;

  dispose() {
    _servicioController.close();
    _servicioProductController.close();
  }

  void getServices() async {
    _servicioController.sink.add(await servicioDatabase.getServicio());
    await configApi.obtenerConfig();
    _servicioController.sink.add(await servicioDatabase.getServicio());
  }

  void getServicProducts() async {
    _servicioProductController.sink.add(await servicioDatabase.getServiceProducto());
    await configApi.obtenerConfig();
    _servicioProductController.sink.add(await servicioDatabase.getServiceProducto());
  }
}
