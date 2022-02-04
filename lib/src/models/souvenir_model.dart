class SourvenirModel {
  String? idProduct;
  String? productTitle;
  String? productDetail;
  String? productImagen;
  String? productPrecio;
  String? productEstado;

  SourvenirModel({
    this.idProduct,
    this.productTitle,
    this.productDetail,
    this.productImagen,
    this.productPrecio,
    this.productEstado,
  });

  static List<SourvenirModel> fromJsonList(List<dynamic> json) => json.map((i) => SourvenirModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "productTitle": productTitle,
        "productDetail": productDetail,
        "productImagen": productImagen,
        "productPrecio": productPrecio,
        "productEstado": productEstado,
      };
  factory SourvenirModel.fromJson(Map<String, dynamic> json) => SourvenirModel(
        idProduct: json["idProduct"],
        productTitle: json["productTitle"],
        productDetail: json["productDetail"],
        productImagen: json["productImagen"],
        productPrecio: json["productPrecio"],
        productEstado: json["productEstado"],
      );
}
