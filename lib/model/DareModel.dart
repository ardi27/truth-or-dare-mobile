// To parse this JSON data, do
//
//     final dareModel = dareModelFromJson(jsonString);

import 'dart:convert';

DareModel dareModelFromJson(String str) => DareModel.fromJson(json.decode(str));

String dareModelToJson(DareModel data) => json.encode(data.toJson());

class DareModel {
  DareModel({
    this.code,
    this.results,
    this.message,
  });

  int code;
  Results results;
  String message;

  factory DareModel.fromJson(Map<String, dynamic> json) => DareModel(
    code: json["code"] == null ? null : json["code"],
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "results": results == null ? null : results.toJson(),
    "message": message == null ? null : message,
  };
}

class Results {
  Results({
    this.uuid,
    this.dare,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.user,
  });

  String uuid;
  String dare;
  String level;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  User user;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    uuid: json["uuid"] == null ? null : json["uuid"],
    dare: json["dare"] == null ? null : json["dare"],
    level: json["level"] == null ? null : json["level"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "dare": dare == null ? null : dare,
    "level": level == null ? null : level,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "user_id": userId == null ? null : userId,
    "user": user == null ? null : user.toJson(),
  };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
