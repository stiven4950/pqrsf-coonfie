import 'dart:convert';

class User {
  User({
    required this.id,
    required this.documentNumber,
    required this.fullname,
    required this.phone,
    required this.email,
  });

  String id;
  int documentNumber;
  String fullname;
  String phone;
  String email;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        documentNumber: json["document_number"],
        fullname: json["fullname"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "document_number": documentNumber,
        "fullname": fullname,
        "phone": phone,
        "email": email,
      };
}
