import 'dart:convert';

List<City> citiesFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String citiesToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
