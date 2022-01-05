import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'quistocha.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(tableEventoSql);
      db.execute(tableEspacioSql);
      db.execute(tableTarifasSql);
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }

  static const String tableEventoSql = 'CREATE TABLE Evento('
      'idEvento TEXT PRIMARY KEY, '
      'eventoNombre TEXT, '
      'eventoFecha TEXT,'
      'eventoHora TEXT,'
      'eventoDireccion TEXT,'
      'eventoEstado TEXT)';

  static const String tableEspacioSql = 'CREATE TABLE Espacio('
      'idEspacio TEXT PRIMARY KEY, '
      'idEvento TEXT, '
      'espacioNombre TEXT, '
      'espacioAforo TEXT,'
      'espacioEstado TEXT)';

  static const String tableTarifasSql = 'CREATE TABLE Tarifas('
      'idTarifa TEXT PRIMARY KEY, '
      'idEspacio TEXT, '
      'tarifaNombre TEXT, '
      'tarifaPrecio TEXT,'
      'tarifaEstado TEXT)';
}
