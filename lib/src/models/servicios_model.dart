class ServicioModel {
  String? idServicio;
  String? servicioTitulo;
  String? servicioDetalle;
  String? servicioImagen;
  String? servicioPrecio;
  String? servicioEstado;
  String? servicioTipo;

  ServicioModel({
    this.idServicio,
    this.servicioTitulo,
    this.servicioDetalle,
    this.servicioImagen,
    this.servicioPrecio,
    this.servicioEstado,
    this.servicioTipo,
  });

  static List<ServicioModel> fromJsonList(List<dynamic> json) => json.map((i) => ServicioModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idServicio": idServicio,
        "servicioTitulo": servicioTitulo,
        "servicioDetalle": servicioDetalle,
        "servicioImagen": servicioImagen,
        "servicioPrecio": servicioPrecio,
        "servicioEstado": servicioEstado,
        "servicioTipo": servicioTipo,
      };
  factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        idServicio: json["idServicio"],
        servicioTitulo: json["servicioTitulo"],
        servicioDetalle: json["servicioDetalle"],
        servicioImagen: json["servicioImagen"],
        servicioPrecio: json["servicioPrecio"],
        servicioEstado: json["servicioEstado"],
        servicioTipo: json["servicioTipo"],
      );
}
