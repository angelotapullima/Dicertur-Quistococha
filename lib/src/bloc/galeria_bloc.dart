  
import 'package:dicertur_quistococha/database/galeria_database.dart';
import 'package:dicertur_quistococha/src/api/config_api.dart';
import 'package:dicertur_quistococha/src/models/galeria_model.dart'; 
import 'package:rxdart/rxdart.dart';

class GaleriaBloc {
  final galeriaDatabase = GaleriaDatabase();
  final configApi = ConfigApi();

  final _servicioController = BehaviorSubject<List<GaleriaModel>>();
  Stream<List<GaleriaModel>> get galeriaStream => _servicioController.stream;

  dispose() {
    _servicioController.close();
  }

  void getGaleria() async {
    _servicioController.sink.add(await galeriaDatabase.getGaleria());
    await configApi.obtenerConfig();
    _servicioController.sink.add(await galeriaDatabase.getGaleria());
  }
}
