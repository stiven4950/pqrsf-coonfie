import 'dart:convert';

List<Matter> matterFromJson(String str) =>
    List<Matter>.from(json.decode(str).map((x) => Matter.fromJson(x)));

String matterToJson(List<Matter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Matter {
  Matter({
    required this.objectId,
    required this.asuntoTipoNom,
  });

  String objectId;
  String asuntoTipoNom;

  factory Matter.fromJson(Map<String, dynamic> json) => Matter(
        objectId: json["objectId"],
        asuntoTipoNom: json["asuntoTipoNom"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "asuntoTipoNom": asuntoTipoNom,
      };
}
