// To parse this JSON data, do
//
//     final matter = matterFromJson(jsonString);

import 'dart:convert';

List<Matter> matterFromJson(String str) =>
    List<Matter>.from(json.decode(str).map((x) => Matter.fromJson(x)));

String matterToJson(List<Matter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Matter {
  Matter({
    required this.asuntoTipoId,
    required this.asuntoTipoNom,
  });

  String asuntoTipoId;
  String asuntoTipoNom;

  factory Matter.fromJson(Map<String, dynamic> json) => Matter(
        asuntoTipoId: json["AsuntoTipoID"],
        asuntoTipoNom: json["AsuntoTipoNom"],
      );

  Map<String, dynamic> toJson() => {
        "AsuntoTipoID": asuntoTipoId,
        "AsuntoTipoNom": asuntoTipoNom,
      };
}
