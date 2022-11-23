// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'details_model.g.dart';

List<DetailsModel> detailsModelFromJson(String str) => List<DetailsModel>.from(json.decode(str).map((x) => DetailsModel.fromJson(x)));

String detailsModelToJson(List<DetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 7)
class DetailsModel extends HiveObject {
  DetailsModel({
    this.topic,
    this.title,
    this.content,
    this.status,
  });

  @HiveField(0)
  int? topic;

  @HiveField(1)
  String? title;

  @HiveField(2)
  List<Content>? content;

  @HiveField(3)
  int? status;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
    topic: json["topic"],
    title: json["title"],
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "title": title,
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    "status": status,
  };
}

@HiveType(typeId: 8)
class Content extends HiveObject {
  Content({
    this.title,
    this.description,
  });

  @HiveField(0)
  String? title;

  @HiveField(1)
  List<Description>? description;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    title: json["title"],
    description: List<Description>.from(json["description"].map((x) => Description.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": List<dynamic>.from(description!.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 9)
class Description extends HiveObject{
  Description({
    this.desc,
  });

  @HiveField(0)
  String? desc;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
  };
}
