import 'dart:convert';

import 'package:pqrf_coonfie/models/city_model.dart';
import 'package:pqrf_coonfie/models/matter_model_2.dart';
import 'package:pqrf_coonfie/models/user_model.dart';

class Filling {
  Filling({
    required this.user,
    required this.city,
    required this.address,
    required this.matter,
    required this.medium,
    required this.description,
    required this.userType,
    required this.ticket,
    required this.state,
    required this.files,
    required this.fillingDate,
    required this.uid,
    //this.responseDate,
  });

  User user;
  City city;
  String address;
  Matter matter;
  String medium;
  String description;
  String userType;
  String ticket;
  String state;
  List<dynamic> files;
  DateTime fillingDate;
  //DateTime? responseDate;
  String uid;

  factory Filling.fromRawJson(String str) => Filling.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Filling.fromJson(Map<String, dynamic> json) => Filling(
        user: User.fromJson(json["user"]),
        city: City.fromJson(json["city"]),
        address: json["address"],
        matter: Matter.fromJson(json["matter"]),
        medium: json["medium"],
        description: json["description"],
        userType: json["user_type"],
        ticket: json["ticket"],
        state: json["state"],
        files: List<dynamic>.from(json["files"].map((x) => x)),
        fillingDate: DateTime.parse(json["filling_date"]),
        //responseDate: DateTime.parse(json["response_date"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "city": city.toJson(),
        "address": address,
        "matter": matter.toJson(),
        "medium": medium,
        "description": description,
        "user_type": userType,
        "ticket": ticket,
        "state": state,
        "files": List<dynamic>.from(files.map((x) => x)),
        "filling_date": fillingDate.toIso8601String(),
        "uid": uid,
      };
}
