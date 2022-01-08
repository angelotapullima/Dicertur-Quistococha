class TarifaModel {
 
  String? idTarifa;
  String? idEspacio;
  String? tarifaNombre;
  String? tarifaPrecio;
  String? tarifaEstado;

  TarifaModel({
    this.idTarifa,
    this.idEspacio,
    this.tarifaNombre,
    this.tarifaPrecio,
    this.tarifaEstado,
  });

  static List<TarifaModel> fromJsonList(List<dynamic> json) => json.map((i) => TarifaModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idTarifa": idTarifa,
        "idEspacio": idEspacio,
        "tarifaNombre": tarifaNombre,
        "tarifaPrecio": tarifaPrecio,
        "tarifaEstado": tarifaEstado,
      };
  factory TarifaModel.fromJson(Map<String, dynamic> json) => TarifaModel(
        idTarifa: json["idTarifa"],
        idEspacio: json["idEspacio"],
        tarifaNombre: json["tarifaNombre"],
        tarifaPrecio: json["tarifaPrecio"],
        tarifaEstado: json["tarifaEstado"],
      );
}
