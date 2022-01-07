import 'package:dicertur_quistococha/src/models/detalle_ticket_model.dart';

class TicketModel {
  String? idTicket;
  String? idUser;
  String? idEvento;
  String? ticketTotal;
  String? ticketDateTime;
  String? ticketTipoPago;
  String? eventoFecha;
  String? ticketCodigoApp;
  String? clienteNombre;
  String? clienteTelefono;
  String? clienteDni;
  String? ticketEstado;

  List<DetalleTicketModel>? detalle;

  TicketModel({
    this.idTicket,
    this.idUser,
    this.idEvento,
    this.ticketTotal,
    this.ticketDateTime,
    this.ticketTipoPago,
    this.eventoFecha,
    this.ticketCodigoApp,
    this.clienteNombre,
    this.clienteTelefono,
    this.clienteDni,
    this.ticketEstado,
    this.detalle,
  });

  static List<TicketModel> fromJsonList(List<dynamic> json) => json.map((i) => TicketModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idTicket": idTicket,
        "idUser": idUser,
        "idEvento": idEvento,
        "ticketTotal": ticketTotal,
        "ticketDateTime": ticketDateTime,
        "ticketTipoPago": ticketTipoPago,
        "eventoFecha": eventoFecha,
        "ticketCodigoApp": ticketCodigoApp,
        "clienteNombre": clienteNombre,
        "clienteTelefono": clienteTelefono,
        "clienteDni": clienteDni,
        "ticketEstado": ticketEstado,
      };
  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        idTicket: json["idTicket"],
        idUser: json["idUser"],
        idEvento: json["idEvento"],
        ticketTotal: json["ticketTotal"],
        ticketDateTime: json["ticketDateTime"],
        ticketTipoPago: json["ticketTipoPago"],
        eventoFecha: json["eventoFecha"],
        ticketCodigoApp: json["ticketCodigoApp"],
        clienteNombre: json["clienteNombre"],
        clienteTelefono: json["clienteTelefono"],
        clienteDni: json["clienteDni"],
        ticketEstado: json["ticketEstado"],
      );
}
