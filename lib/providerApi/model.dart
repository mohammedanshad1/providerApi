// To parse this JSON data, do
//
//     final models = modelsFromJson(jsonString);

import 'dart:convert';

Models modelsFromJson(String str) => Models.fromJson(json.decode(str));

//String modelsToJson(Models data) => json.encode(data.toJson());

class Models {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Datum>? data;
  Support? support;

  Models({
     this.page,
     this.perPage,
  this.total,
  this.totalPages,
    this.data,
     this.support,
  });

  factory Models.fromJson(Map<String, dynamic> json) => Models(
    page: json["page"]??.0,
    perPage: json["per_page"]??.0,
    total: json["total"]??.0,
    totalPages: json["total_pages"]??.0,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    support: Support.fromJson(json["support"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "page": page,
  //   "per_page": perPage,
  //   "total": total,
  //   "total_pages": totalPages,
  //   "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //   "support": support.toJson(),
  // };
}

class Datum {
  int id;
  String  ? email;
  String ? firstName;
  String ? lastName;
  String ? avatar;

  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}
