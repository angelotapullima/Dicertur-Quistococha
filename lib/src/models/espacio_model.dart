class EspacioModel {

  String? idEspacio;
  String? idEvento;
  String? espacioNombre;
  String? espacioAforo;
  String? espacioEstado;

  EspacioModel({
    this.idEspacio,
    this.idEvento,
    this.espacioNombre,
    this.espacioAforo,
    this.espacioEstado,
  });
  

  static List<EspacioModel> fromJsonList(List<dynamic> json) => json.map((i) => EspacioModel.fromJson(i)).toList();



  Map<String, dynamic> toJson() => {
    "idEspacio": idEspacio,
    "idEvento": idEvento,
    "espacioNombre": espacioNombre,
    "espacioAforo": espacioAforo,
    "espacioEstado": espacioEstado,
  };
  factory EspacioModel.fromJson(Map<String, dynamic> json) => EspacioModel(
        idEspacio: json["idEspacio"],
        idEvento: json["idEvento"],
        espacioNombre: json["espacioNombre"],
        espacioAforo: json["espacioAforo"],
        espacioEstado: json["espacioEstado"],
      );
}

