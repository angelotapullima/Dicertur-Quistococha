import 'package:rxdart/rxdart.dart';

class NuevoMetodoPagoBloc {
  final _estadoWebviewController = BehaviorSubject<bool>();
  Stream<bool> get estadoWebview => _estadoWebviewController.stream;

  //funciones para cambio
  Function(bool) get changeEstadoWebview => _estadoWebviewController.sink.add;

  // Obtener el último valor ingresado a los streams
  bool? get valorEstadoWe => _estadoWebviewController.value;

  dispose() {
    _estadoWebviewController.close();
  }
}
