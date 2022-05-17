import 'dart:convert';

List<Agency> agencyFromJson(String str) =>
    List<Agency>.from(json.decode(str).map((x) => Agency.fromJson(x)));

String agencyToJson(List<Agency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agency {
  Agency({
    required this.agenciaId,
    required this.agenciaNombre,
  });

  int agenciaId;
  String agenciaNombre;

  factory Agency.fromJson(Map<String, dynamic> json) => Agency(
        agenciaId: json["AgenciaId"],
        agenciaNombre: json["AgenciaNombre"],
      );

  Map<String, dynamic> toJson() => {
        "AgenciaId": agenciaId,
        "AgenciaNombre": agenciaNombre,
      };
}
