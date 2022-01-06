import 'package:dicertur_quistococha/src/bloc/bottom_navigation_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/evento_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/nuevo_metodo_pago_bloc.dart';
import 'package:flutter/material.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  final bottomNaviBloc = BottomNaviBloc();
  final eventoBloc = EventoBloc();
  final nuevoMetodoBloc = NuevoMetodoPagoBloc();

  ProviderBloc({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static BottomNaviBloc bottom(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.bottomNaviBloc;
  }

  static EventoBloc evento(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.eventoBloc;
  }

  static NuevoMetodoPagoBloc nuevopago(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.nuevoMetodoBloc;
  }
}
