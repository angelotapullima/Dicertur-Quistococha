class EventoModel {
  String? idEvento;
  String? eventoNombre;
  String? eventoFecha;
  String? eventoHora;
  String? eventoDireccion;
  String? eventoEstado;

  EventoModel({
    this.idEvento,
    this.eventoNombre,
    this.eventoFecha,
    this.eventoHora,
    this.eventoDireccion,
    this.eventoEstado,
  });

  static List<EventoModel> fromJsonList(List<dynamic> json) => json.map((i) => EventoModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idEvento": idEvento,
        "eventoNombre": eventoNombre,
        "eventoFecha": eventoFecha,
        "eventoHora": eventoHora,
        "eventoDireccion": eventoDireccion,
        "eventoEstado": eventoEstado,
      };
  factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
        idEvento: json["idEvento"],
        eventoNombre: json["eventoNombre"],
        eventoFecha: json["eventoFecha"],
        eventoHora: json["eventoHora"],
        eventoDireccion: json["eventoDireccion"],
        eventoEstado: json["eventoEstado"],
      );
}
