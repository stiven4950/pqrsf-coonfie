import 'dart:convert';

List<Municipios> municipiosFromJson(String str) =>
    List<Municipios>.from(json.decode(str).map((x) => Municipios.fromJson(x)));

String municipiosToJson(List<Municipios> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Municipios {
  Municipios({
    required this.objectId,
    required this.municipioDepartamento,
  });

  String objectId;
  String municipioDepartamento;

  factory Municipios.fromJson(Map<String, dynamic> json) => Municipios(
        objectId: json["objectId"],
        municipioDepartamento: json["municipioDepartamento"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "municipioDepartamento": municipioDepartamento,
      };
}
