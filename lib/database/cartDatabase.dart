import 'package:dicertur_quistococha/database/databd_config.dart';
import 'package:dicertur_quistococha/src/models/cart_model.dart';
import 'package:sqflite/sqlite_api.dart';

class CartDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertCart(CartModel cart) async {
    try {
      final Database db = await dbprovider.getDatabase();
      await db.rawInsert('INSERT OR REPLACE INTO Cart (idRelated,type,amount,subtotal) '
          'VALUES ( "${cart.idRelated}" , "${cart.type}" ,"${cart.amount}" ,"${cart.subtotal}"  )');
    } catch (e) {
      print("$e Error en la tabla Cart");
    }
  }

  Future<List<CartModel>> getCart() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<CartModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Cart ");

      if (maps.length > 0) list = CartModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Cart");
      return [];
    }
  }

  updateCart(CartModel cart) async {
    final db = await dbprovider.database;

    final res = await db.rawUpdate('UPDATE Cart SET '
        'idRelated="${cart.idRelated}", '
        'type="${cart.type}", '
        'amount="${cart.amount}", '
        'subtotal="${cart.subtotal}"  '
        'WHERE idCart = "${cart.idCart}"   ');

    return res;
  }

  Future<List<CartModel>> getCartForIdRelatedAndType(String idRelated, String type) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<CartModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Cart WHERE idRelated='$idRelated' and type='$type'");

      if (maps.length > 0) list = CartModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Cart");
      return [];
    }
  }

  deleteCart() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Cart ");

    return res;
  }
  deleteCartForIdCart(String idCart) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Cart WHERE idCart='$idCart' ");

    return res;
  }
/* 
  deleteCartForId(String idProduct) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Cart WHERE idProduct='$idProduct'");

    return res;
  } */
}
