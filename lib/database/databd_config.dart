import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'quistocha.db');
    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    //final String path = join(await getDatabasesPath(), 'quistocha.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(tableEventoSql);
        db.execute(tableEspacioSql);
        db.execute(tableTarifasSql);
        db.execute(tableTicketSql);
        db.execute(tableDetalleTicketSql);
        db.execute(tableCuentosSql);
        db.execute(tableServiciosSql);
        db.execute(tableForoSql);
        db.execute(tableGaleriaSql);
        db.execute(tableCartSql);
        db.execute(tableSouvenirSql);
      },
      version: 1,
      onConfigure: _onConfigure,
    );
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
      'espacioStock TEXT,'
      'espacioEstado TEXT)';

  static const String tableTarifasSql = 'CREATE TABLE Tarifas('
      'idTarifa TEXT PRIMARY KEY, '
      'idEspacio TEXT, '
      'tarifaNombre TEXT, '
      'tarifaPrecio TEXT,'
      'tarifaEstado TEXT)';

  /*
      0 es cuando fue creado, 1 cuando fue usado parcialmente y 2 cuando ya fue usado por completo
    */
  static const String tableTicketSql = 'CREATE TABLE Ticket('
      'idTicket TEXT PRIMARY KEY, '
      'idUser TEXT, '
      'idEvento TEXT, '
      'ticketTotal TEXT,'
      'ticketDateTime TEXT,'
      'eventoFecha TEXT,'
      'eventoHoraInicio TEXT,'
      'eventoHoraFin TEXT,'
      'ticketTipoPago TEXT,'
      'ticketCodigoApp TEXT,'
      'clienteNombre TEXT,'
      'clienteTelefono TEXT,'
      'clienteDni TEXT,'
      'ticketEstado TEXT,'
      'rucQR TEXT,'
      'ventaTipoQR TEXT,'
      'ventaSerieQR TEXT,'
      'ventaCorrelativoQR TEXT,'
      'ventaTotalIGVQR TEXT,'
      'ventaTotalQR TEXT,'
      'ventaFechaQR TEXT,'
      'clienteTipoDocumetoCodigoQR TEXT,'
      'clienteNumeroQR TEXT)';

  static const String tableDetalleTicketSql = 'CREATE TABLE DetalleTicket('
      'idDetalleTicket TEXT PRIMARY KEY, '
      'idTicket TEXT, '
      'tarifaNombre TEXT, '
      'tarifaPrecio TEXT,'
      'tarifaDetalleCantidad TEXT,'
      'idTarifa TEXT,'
      'tarifaDetalleSubTotal TEXT,'
      'ticketDetalleUsados TEXT,'
      'detalleTicketEstado TEXT)';

  static const String tableCuentosSql = 'CREATE TABLE Cuentos('
      'idCuento TEXT PRIMARY KEY, '
      'cuentoTitulo TEXT, '
      'cuentoDetalle TEXT, '
      'cuentoImagen TEXT,'
      'cuentoEstado TEXT)';

  static const String tableGaleriaSql = 'CREATE TABLE Galeria('
      'idGaleria TEXT PRIMARY KEY, '
      'galeriaFoto TEXT, '
      'galeriaEstado TEXT)';

  static const String tableServiciosSql = 'CREATE TABLE Servicios('
      'idServicio TEXT PRIMARY KEY, '
      'servicioTitulo TEXT, '
      'servicioDetalle TEXT, '
      'servicioImagen TEXT,'
      'servicioPrecio TEXT,'
      'servicioEstado TEXT)';
  static const String tableSouvenirSql = 'CREATE TABLE Souvenir('
      'idProduct TEXT PRIMARY KEY, '
      'productTitle TEXT, '
      'productDetail TEXT, '
      'productImagen TEXT,'
      'productPrecio TEXT,'
      'productEstado TEXT)';

  static const String tableForoSql = 'CREATE TABLE Foro('
      'idForo TEXT PRIMARY KEY , '
      'idUsuario TEXT, '
      'foroTitulo TEXT, '
      'foroDatetime TEXT, '
      'foroDetalle TEXT, '
      'personaName TEXT,'
      'personaSurName TEXT,'
      'usuarioImagen TEXT,'
      'foroImagen TEXT,'
      'foroEstado TEXT)';

  static const String tableCartSql = 'CREATE TABLE Cart('
      'idCart INTEGER PRIMARY KEY AUTOINCREMENT, '
      'idRelated TEXT, '
      'type TEXT, '
      'amount TEXT,'
      'subtotal TEXT)';
}
