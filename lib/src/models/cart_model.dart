class CartModel {
  int? idCart;
  String? idRelated;
  String? type;
  String? amount;
  String? subtotal;
  String? name;
  String? description;
  String? price;
  String? image;

  CartModel({
    this.idCart,
    this.idRelated,
    this.type,
    this.amount,
    this.subtotal,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  static List<CartModel> fromJsonList(List<dynamic> json) => json.map((i) => CartModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idRelated': idRelated,
        'amount': amount,
        'subtotal': subtotal,
        'type': type,
      };

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        idCart: json["idCart"],
        idRelated: json["idRelated"],
        amount: json["amount"],
        subtotal: json["subtotal"],
        type: json["type"],
      );
}
