class DetalleTicketModel {
  String? idDetalleTicket;
  String? idTicket;
  String? tarifaNombre;
  String? tarifaPrecio;
  String? tarifaDetalleCantidad;
  String? tarifaDetalleSubTotal;
  String? tarifaDetalleEstado;

  DetalleTicketModel({
    this.idDetalleTicket,
    this.idTicket,
    this.tarifaNombre,
    this.tarifaPrecio,
    this.tarifaDetalleCantidad,
    this.tarifaDetalleSubTotal,
    this.tarifaDetalleEstado,
  });

  static List<DetalleTicketModel> fromJsonList(List<dynamic> json) => json.map((i) => DetalleTicketModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idDetalleTicket": idDetalleTicket,
        "idTicket": idTicket,
        "tarifaNombre": tarifaNombre,
        "tarifaPrecio": tarifaPrecio,
        "tarifaDetalleCantidad": tarifaDetalleCantidad,
        "tarifaDetalleSubTotal": tarifaDetalleSubTotal,
        "tarifaDetalleEstado": tarifaDetalleEstado,
      };
  factory DetalleTicketModel.fromJson(Map<String, dynamic> json) => DetalleTicketModel(
        idDetalleTicket: json["idDetalleTicket"],
        idTicket: json["idTicket"],
        tarifaNombre: json["tarifaNombre"],
        tarifaPrecio: json["tarifaPrecio"],
        tarifaDetalleCantidad: json["tarifaDetalleCantidad"],
        tarifaDetalleSubTotal: json["tarifaDetalleSubTotal"],
        tarifaDetalleEstado: json["tarifaDetalleEstado"],
      );
}
