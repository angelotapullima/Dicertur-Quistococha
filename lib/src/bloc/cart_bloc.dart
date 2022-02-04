import 'package:dicertur_quistococha/database/cartDatabase.dart';
import 'package:dicertur_quistococha/database/servicio_database.dart';
import 'package:dicertur_quistococha/database/souvenir_database.dart';
import 'package:dicertur_quistococha/src/models/cart_model.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final cartDatabase = CartDatabase();
  final servicioDatabase = ServicioDatabase();
  final souvenirDatabase = SouvenirDatabase();

  final _cartController = BehaviorSubject<List<CartModel>>();
  Stream<List<CartModel>> get cartStream => _cartController.stream;

  dispose() {
    _cartController.close();
  }

  void getCart() async {
    final List<CartModel> cartFinal = [];

    final listCart = await cartDatabase.getCart();

    if (listCart.length > 0) {
      for (var i = 0; i < listCart.length; i++) {
        if (listCart[i].type == '1') {
          //servicios
          final ser = await servicioDatabase.getServiceForId(listCart[i].idRelated.toString());
          if (ser.length > 0) {
            CartModel cartModel = CartModel();
            cartModel.idCart = listCart[i].idCart;
            cartModel.idRelated = ser[0].idServicio;
            cartModel.name = ser[0].servicioTitulo;
            cartModel.description = ser[0].servicioDetalle;
            cartModel.image = ser[0].servicioImagen;
            cartModel.price = ser[0].servicioPrecio;
            cartModel.amount = listCart[i].amount;
            cartModel.subtotal = listCart[i].subtotal;
            cartModel.type = '1';

            cartFinal.add(cartModel);
          }
        } else {
          //Sourvenirs

          final ser = await souvenirDatabase.getSouvenirsForId(listCart[i].idRelated.toString());
          if (ser.length > 0) {
            CartModel cartModel = CartModel();
            cartModel.idCart = listCart[i].idCart;
            cartModel.idRelated = ser[0].idProduct;
            cartModel.name = ser[0].productTitle;
            cartModel.description = ser[0].productDetail;
            cartModel.image = ser[0].productImagen;
            cartModel.price = ser[0].productPrecio;
            cartModel.amount = listCart[i].amount;
            cartModel.subtotal = listCart[i].subtotal;
            cartModel.type = '2';

            cartFinal.add(cartModel);
          }
        }
      }
    }
    _cartController.sink.add(cartFinal);
  }
}
