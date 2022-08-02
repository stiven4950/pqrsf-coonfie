import 'dart:convert';

List<City> citiesFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String citiesToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.cod,
    required this.name,
  });

  String cod;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cod: json["cod"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "name": name,
      };
}
