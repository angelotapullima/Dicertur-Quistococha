class GaleriaModel {
  String? idGaleria;
  String? galeriaFoto;
  String? galeriaEstado;

  GaleriaModel({this.idGaleria, this.galeriaFoto, this.galeriaEstado});

  static List<GaleriaModel> fromJsonList(List<dynamic> json) => json.map((i) => GaleriaModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idGaleria": idGaleria,
        "galeriaFoto": galeriaFoto,
        "galeriaEstado": galeriaEstado,
      };
  factory GaleriaModel.fromJson(Map<String, dynamic> json) => GaleriaModel(
        idGaleria: json["idGaleria"],
        galeriaFoto: json["galeriaFoto"],
        galeriaEstado: json["galeriaEstado"],
      );
}
