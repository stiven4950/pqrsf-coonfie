import 'dart:convert';

List<Municipios> municipiosFromJson(String str) =>
    List<Municipios>.from(json.decode(str).map((x) => Municipios.fromJson(x)));

String municipiosToJson(List<Municipios> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Municipios {
  Municipios({
    required this.municipioId,
    required this.municipioDepartamento,
  });

  String municipioId;
  String municipioDepartamento;

  factory Municipios.fromJson(Map<String, dynamic> json) => Municipios(
        municipioId: json["MunicipioId"],
        municipioDepartamento: json["MunicipioDepartamento"],
      );

  Map<String, dynamic> toJson() => {
        "MunicipioId": municipioId,
        "MunicipioDepartamento": municipioDepartamento,
      };
}
