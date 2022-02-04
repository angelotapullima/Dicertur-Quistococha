import 'package:dicertur_quistococha/src/bloc/bottom_navigation_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/cart_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/cuentos_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/data_user.dart';
import 'package:dicertur_quistococha/src/bloc/evento_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/foro_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/galeria_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/nuevo_metodo_pago_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/servicio_bloc.dart';
import 'package:dicertur_quistococha/src/bloc/ticket_bloc.dart';
import 'package:flutter/material.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  final bottomNaviBloc = BottomNaviBloc();
  final eventoBloc = EventoBloc();
  final nuevoMetodoBloc = NuevoMetodoPagoBloc();
  final ticketBloc = TicketBloc();
  final dataUserBloc = DataUserBloc();
  final cuentosBloc = CuentosBloc();
  final servicioBloc = ServicioBloc();
  final foroBloc = ForoBloc();
  final galeriaBloc = GaleriaBloc();
  final cartBloc = CartBloc();

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

  static TicketBloc ticket(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.ticketBloc;
  }

  static DataUserBloc data(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.dataUserBloc;
  }

  static CuentosBloc cuentos(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.cuentosBloc;
  }

  static ServicioBloc servi(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.servicioBloc;
  }

  static ForoBloc foro(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.foroBloc;
  }
  

  static GaleriaBloc galeria(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.galeriaBloc;
  }

  static CartBloc cart(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())!.cartBloc;
  }

}
