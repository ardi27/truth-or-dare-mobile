// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
