// To parse this JSON data, do
//
//     final jwtModel = jwtModelFromJson(jsonString);

import 'dart:convert';

JwtModel jwtModelFromJson(String str) => JwtModel.fromJson(json.decode(str));

String jwtModelToJson(JwtModel data) => json.encode(data.toJson());

class JwtModel {
  JwtModel({
    this.iss,
    this.sub,
    this.iat,
  });

  String iss;
  Sub sub;
  int iat;

  factory JwtModel.fromJson(Map<String, dynamic> json) => JwtModel(
    iss: json["iss"] == null ? null : json["iss"],
    sub: json["sub"] == null ? null : Sub.fromJson(json["sub"]),
    iat: json["iat"] == null ? null : json["iat"],
  );

  Map<String, dynamic> toJson() => {
    "iss": iss == null ? null : iss,
    "sub": sub == null ? null : sub.toJson(),
    "iat": iat == null ? null : iat,
  };
}

class Sub {
  Sub({
    this.uuid,
    this.username,
    this.name,
    this.email,
    this.profilePhotoUrl,
    this.createdAt,
    this.updatedAt,
  });

  String uuid;
  String username;
  String name;
  String email;
  dynamic profilePhotoUrl;
  DateTime createdAt;
  DateTime updatedAt;

  factory Sub.fromJson(Map<String, dynamic> json) => Sub(
    uuid: json["uuid"] == null ? null : json["uuid"],
    username: json["username"] == null ? null : json["username"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    profilePhotoUrl: json["profile_photo_url"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "username": username == null ? null : username,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "profile_photo_url": profilePhotoUrl,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
