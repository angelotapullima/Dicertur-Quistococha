
import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  

  // Use cases
  sl.registerLazySingleton(() => ProviderBloc(child: sl(),));
}