// To parse this JSON data, do
//
//     final userTruthModel = userTruthModelFromJson(jsonString);

import 'dart:convert';

UserTruthModel userTruthModelFromJson(String str) => UserTruthModel.fromJson(json.decode(str));

String userTruthModelToJson(UserTruthModel data) => json.encode(data.toJson());

class UserTruthModel {
  UserTruthModel({
    this.code,
    this.results,
    this.message,
  });

  int code;
  Results results;
  String message;

  factory UserTruthModel.fromJson(Map<String, dynamic> json) => UserTruthModel(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<UserTruth> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<UserTruth>.from(json["data"].map((x) => UserTruth.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "links": links == null ? null : List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class UserTruth {
  UserTruth({
    this.uuid,
    this.truth,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  String uuid;
  String truth;
  String level;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;

  factory UserTruth.fromJson(Map<String, dynamic> json) => UserTruth(
    uuid: json["uuid"] == null ? null : json["uuid"],
    truth: json["truth"] == null ? null : json["truth"],
    level: json["level"] == null ? null : json["level"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userId: json["user_id"] == null ? null : json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "truth": truth == null ? null : truth,
    "level": level == null ? null : level,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "user_id": userId == null ? null : userId,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  dynamic label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active == null ? null : active,
  };
}
