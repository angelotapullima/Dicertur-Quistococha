class CuentosModel {
  String? idCuento;
  String? cuentoTitulo;
  String? cuentoDetalle;
  String? cuentoImagen;
  String? cuentoEstado;

  CuentosModel({
    this.idCuento,
    this.cuentoTitulo,
    this.cuentoDetalle,
    this.cuentoImagen,
    this.cuentoEstado,
  });

  static List<CuentosModel> fromJsonList(List<dynamic> json) => json.map((i) => CuentosModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idCuento": idCuento,
        "cuentoTitulo": cuentoTitulo,
        "cuentoDetalle": cuentoDetalle,
        "cuentoImagen": cuentoImagen,
        "cuentoEstado": cuentoEstado,
      };
  factory CuentosModel.fromJson(Map<String, dynamic> json) => CuentosModel(
        idCuento: json["idCuento"],
        cuentoTitulo: json["cuentoTitulo"],
        cuentoDetalle: json["cuentoDetalle"],
        cuentoImagen: json["cuentoImagen"],
        cuentoEstado: json["cuentoEstado"],
      );
}
