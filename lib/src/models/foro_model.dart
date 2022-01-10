class ForoModel {
  String? idForo;
  String? idUsuario;
  String? foroTitulo;
  String? foroDatetime;
  String? foroDetalle;
  String? personaName;
  String? personaSurName;
  String? foroImagen;
  String? foroEstado;

  ForoModel({
    this.idForo,
    this.idUsuario,
    this.foroTitulo,
    this.foroDatetime,
    this.foroDetalle,
    this.personaName,
    this.personaSurName,
    this.foroImagen,
    this.foroEstado,
  });

  static List<ForoModel> fromJsonList(List<dynamic> json) => json.map((i) => ForoModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idForo": idForo,
        "idUsuario": idUsuario,
        "foroTitulo": foroTitulo,
        "foroDatetime": foroDatetime,
        "foroDetalle": foroDetalle,
        "personaName": personaName,
        "personaSurName": personaSurName,
        "foroImagen": foroImagen,
        "foroEstado": foroEstado,
      };
  factory ForoModel.fromJson(Map<String, dynamic> json) => ForoModel(
        idForo: json["idForo"],
        idUsuario: json["idUsuario"],
        foroTitulo: json["foroTitulo"],
        foroDatetime: json["foroDatetime"],
        foroDetalle: json["foroDetalle"],
        personaName: json["personaName"],
        personaSurName: json["personaSurName"],
        foroImagen: json["foroImagen"],
        foroEstado: json["foroEstado"],
      );
}
