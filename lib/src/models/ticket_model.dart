import 'package:dicertur_quistococha/src/models/detalle_ticket_model.dart';

class TicketModel {
  String? idTicket;
  String? idUser;
  String? idEvento;
  String? ticketTotal;
  String? ticketDateTime;
  String? ticketTipoPago;
  String? ticketTipo;
  String? eventoFecha;
  String? ticketCodigoApp;
  String? clienteNombre;
  String? clienteTelefono;
  String? clienteDni;
  String? eventoHoraInicio;
  String? eventoHoraFin;
  String? ticketEstado;
  String? rucQR;
  String? ventaTipoQR;
  String? ventaSerieQR;
  String? ventaCorrelativoQR;
  String? ventaTotalIGVQR;
  String? ventaTotalQR;
  String? ventaFechaQR;
  String? clienteTipoDocumetoCodigoQR;
  String? clienteNumeroQR;

  List<DetalleTicketModel>? detalle;

  TicketModel({
    this.idTicket,
    this.idUser,
    this.idEvento,
    this.ticketTotal,
    this.ticketDateTime,
    this.ticketTipoPago,
    this.ticketTipo,
    this.eventoFecha,
    this.ticketCodigoApp,
    this.clienteNombre,
    this.clienteTelefono,
    this.clienteDni,
    this.eventoHoraInicio,
    this.eventoHoraFin,
    this.ticketEstado,
    this.detalle,
    this.rucQR,
    this.ventaTipoQR,
    this.ventaSerieQR,
    this.ventaCorrelativoQR,
    this.ventaTotalIGVQR,
    this.ventaTotalQR,
    this.ventaFechaQR,
    this.clienteTipoDocumetoCodigoQR,
    this.clienteNumeroQR,
  });

  static List<TicketModel> fromJsonList(List<dynamic> json) => json.map((i) => TicketModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idTicket": idTicket,
        "idUser": idUser,
        "idEvento": idEvento,
        "ticketTotal": ticketTotal,
        "ticketDateTime": ticketDateTime,
        "ticketTipoPago": ticketTipoPago,
        "ticketTipo": ticketTipo,
        "eventoFecha": eventoFecha,
        "ticketCodigoApp": ticketCodigoApp,
        "clienteNombre": clienteNombre,
        "clienteTelefono": clienteTelefono,
        "clienteDni": clienteDni,
        "eventoHoraInicio": eventoHoraInicio,
        "eventoHoraFin": eventoHoraFin,
        "ticketEstado": ticketEstado,
        "rucQR": rucQR,
        "ventaTipoQR": ventaTipoQR,
        "ventaSerieQR": ventaSerieQR,
        "ventaCorrelativoQR": ventaCorrelativoQR,
        "ventaTotalIGVQR": ventaTotalIGVQR,
        "ventaTotalQR": ventaTotalQR,
        "ventaFechaQR": ventaFechaQR,
        "clienteTipoDocumetoCodigoQR": clienteTipoDocumetoCodigoQR,
        "clienteNumeroQR": clienteNumeroQR,
      };
  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        idTicket: json["idTicket"],
        idUser: json["idUser"],
        idEvento: json["idEvento"],
        ticketTotal: json["ticketTotal"],
        ticketDateTime: json["ticketDateTime"],
        ticketTipoPago: json["ticketTipoPago"],
        ticketTipo: json["ticketTipo"],
        eventoFecha: json["eventoFecha"],
        ticketCodigoApp: json["ticketCodigoApp"],
        clienteNombre: json["clienteNombre"],
        clienteTelefono: json["clienteTelefono"],
        clienteDni: json["clienteDni"],
        eventoHoraInicio: json["eventoHoraInicio"],
        eventoHoraFin: json["eventoHoraFin"],
        ticketEstado: json["ticketEstado"],
        rucQR: json["rucQR"],
        ventaTipoQR: json["ventaTipoQR"],
        ventaSerieQR: json["ventaSerieQR"],
        ventaCorrelativoQR: json["ventaCorrelativoQR"],
        ventaTotalIGVQR: json["ventaTotalIGVQR"],
        ventaTotalQR: json["ventaTotalQR"],
        ventaFechaQR: json["ventaFechaQR"],
        clienteTipoDocumetoCodigoQR: json["clienteTipoDocumetoCodigoQR"],
        clienteNumeroQR: json["clienteNumeroQR"],
      );
}
