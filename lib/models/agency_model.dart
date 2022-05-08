import 'dart:convert';

List<Agency> agencyFromJson(String str) =>
    List<Agency>.from(json.decode(str).map((x) => Agency.fromJson(x)));

String agencyToJson(List<Agency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agency {
  Agency({
    required this.objectId,
    required this.agenciaNombre,
  });

  String objectId;
  String agenciaNombre;

  factory Agency.fromJson(Map<String, dynamic> json) => Agency(
        objectId: json["objectId"],
        agenciaNombre: json["agenciaNombre"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "agenciaNombre": agenciaNombre,
      };
}
