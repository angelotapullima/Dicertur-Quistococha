import 'package:dicertur_quistococha/database/foro_database.dart';
import 'package:dicertur_quistococha/src/api/foro_api.dart';
import 'package:dicertur_quistococha/src/models/foro_model.dart';
import 'package:rxdart/rxdart.dart';

class ForoBloc {
  final foroDatabase = ForoDatabase();

  final foroApi = ForoApi();

  final _foroController = BehaviorSubject<List<ForoModel>>();
  final _cargandoController = BehaviorSubject<bool>();
  Stream<List<ForoModel>> get foroStream => _foroController.stream;
  Stream<bool> get cargandoStream => _cargandoController.stream;

  dispose() {
    _foroController.close();
    _cargandoController.close();
  }

  void getForos() async {
    _cargandoController.sink.add(true);
    _foroController.sink.add(await foroDatabase.getForo());
    await foroApi.getForos();
    _foroController.sink.add(await foroDatabase.getForo());
    _cargandoController.sink.add(false);
  }
}
