class EspacioModel {

  String? idEspacio;
  String? idEvento;
  String? espacioNombre;
  String? espacioAforo;
  String? espacioStock;
  String? espacioEstado;

  EspacioModel({
    this.idEspacio,
    this.idEvento,
    this.espacioNombre,
    this.espacioAforo,
    this.espacioStock,
    this.espacioEstado,
  });
  

  static List<EspacioModel> fromJsonList(List<dynamic> json) => json.map((i) => EspacioModel.fromJson(i)).toList();



  Map<String, dynamic> toJson() => {
    "idEspacio": idEspacio,
    "idEvento": idEvento,
    "espacioNombre": espacioNombre,
    "espacioAforo": espacioAforo,
    "espacioStock": espacioStock,
    "espacioEstado": espacioEstado,
  };
  factory EspacioModel.fromJson(Map<String, dynamic> json) => EspacioModel(
        idEspacio: json["idEspacio"],
        idEvento: json["idEvento"],
        espacioNombre: json["espacioNombre"],
        espacioAforo: json["espacioAforo"],
        espacioStock: json["espacioStock"],
        espacioEstado: json["espacioEstado"],
      );
}

