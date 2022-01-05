import 'package:dicertur_quistococha/src/api/tarifas_api.dart';
import 'package:dicertur_quistococha/src/models/espacio_model.dart';
import 'package:dicertur_quistococha/src/models/evento_model.dart';
import 'package:dicertur_quistococha/src/models/tarifa_model.dart';
import 'package:rxdart/rxdart.dart';

class EventoBloc {
  final tarifaApi = TarifaApi();
  final _eventoController = BehaviorSubject<List<EventoModel>>();
  Stream<List<EventoModel>> get eventoStream => _eventoController.stream;

  final _tarifasController = BehaviorSubject<List<TarifaModel>>();
  Stream<List<TarifaModel>> get tarifaStream => _tarifasController.stream;

  dispose() {
    _eventoController.close();
    _tarifasController.close();
  }

  void obtenerEventoFecha(String fecha) async {
    _eventoController.sink.add([]);
    _eventoController.sink.add(await getEventoEspacioPorFecha(fecha));
  }

  void obtenerTarifas(String idEspacio) async {
    _tarifasController.sink.add([]);
    _tarifasController.sink.add(await tarifaApi.tarifaDatabase.getTarifaForIdEspacio(idEspacio));
  }

  Future<List<EventoModel>> getEventoEspacioPorFecha(String fecha) async {
    final List<EventoModel> returnlista = [];
    final evento = await tarifaApi.eventoDatabase.getEventoPorFecha(fecha);

    if (evento.length > 0) {
      final espacio = await tarifaApi.espacioDatabase.getEspacio(evento[0].idEvento.toString());
      if (espacio.length > 0) {
        final List<EspacioModel> listEspacio = [];
        listEspacio.add(espacio[0]);

        EventoModel eventoguardar = EventoModel();

        eventoguardar.idEvento = evento[0].idEvento;
        eventoguardar.eventoNombre = evento[0].eventoNombre;
        eventoguardar.eventoFecha = evento[0].eventoFecha;
        eventoguardar.eventoHora = evento[0].eventoHora;
        eventoguardar.eventoDireccion = evento[0].eventoDireccion;
        eventoguardar.eventoEstado = evento[0].eventoEstado;
        eventoguardar.espacio = listEspacio;
        returnlista.add(eventoguardar);
      }
    }
    return returnlista;
  }
}
