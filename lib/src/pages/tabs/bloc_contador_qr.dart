import 'package:flutter/material.dart';

class ContadorQrBloc with ChangeNotifier {
  ValueNotifier<int> _valor = ValueNotifier(0);
  ValueNotifier<int> get valor => this._valor;

  void changeValorQr(int val) {
    _valor.value = val;
    notifyListeners();
  }
}
