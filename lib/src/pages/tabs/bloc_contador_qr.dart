import 'package:flutter/material.dart';

class ContadorQrBloc with ChangeNotifier {
  
  ValueNotifier<int> _valor = ValueNotifier(0);
  ValueNotifier<int> get valor => this._valor;

  ValueNotifier<bool> _cargando = ValueNotifier(false);
  ValueNotifier<bool> get cargando => this._cargando;



  void changeValorQr(int val) {
    _valor.value = val;
    notifyListeners();
  }


  void changeCargando(bool val) {
    _cargando.value = val;
    notifyListeners();
  }
}
