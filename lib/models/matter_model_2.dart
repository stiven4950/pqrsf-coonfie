import 'dart:convert';

List<Matter> matterFromJson(String str) =>
    List<Matter>.from(json.decode(str).map((x) => Matter.fromJson(x)));

String matterToJson(List<Matter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Matter {
  Matter({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Matter.fromJson(Map<String, dynamic> json) => Matter(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
