class ServicioModel {
  String? idServicio;
  String? servicioTitulo;
  String? servicioDetalle;
  String? servicioImagen;
  String? servicioEstado;

  ServicioModel({
    this.idServicio,
    this.servicioTitulo,
    this.servicioDetalle,
    this.servicioImagen,
    this.servicioEstado,
  });

  static List<ServicioModel> fromJsonList(List<dynamic> json) => json.map((i) => ServicioModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idServicio": idServicio,
        "servicioTitulo": servicioTitulo,
        "servicioDetalle": servicioDetalle,
        "servicioImagen": servicioImagen,
        "servicioEstado": servicioEstado,
      };
  factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        idServicio: json["idServicio"],
        servicioTitulo: json["servicioTitulo"],
        servicioDetalle: json["servicioDetalle"],
        servicioImagen: json["servicioImagen"],
        servicioEstado: json["servicioEstado"],
      );
}
