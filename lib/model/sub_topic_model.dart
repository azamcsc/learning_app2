// To parse this JSON data, do
//
//     final subTopicModel = subTopicModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'sub_topic_model.g.dart';

List<SubTopicModel> subTopicModelFromJson(String str) => List<SubTopicModel>.from(json.decode(str).map((x) => SubTopicModel.fromJson(x)));

String subTopicModelToJson(List<SubTopicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 4)
class SubTopicModel extends HiveObject {
  SubTopicModel({
    this.topic,
    this.title,
    this.overview,
    this.lessons,
    this.assessment,
  });

  @HiveField(0)
  int? topic;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? overview;

  @HiveField(3)
  List<Lessons>? lessons;

  @HiveField(4)
  List<Assessment>? assessment;

  factory SubTopicModel.fromJson(Map<String, dynamic> json) => SubTopicModel(
    topic: json["topic"],
    title: json["title"],
    overview: json["overview"],
    lessons: List<Lessons>.from(json["lessons"].map((x) => Lessons.fromJson(x))),
    assessment: List<Assessment>.from(json["assessment"].map((x) => Assessment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "title": title,
    "overview": overview,
    "lessons": List<dynamic>.from(lessons!.map((x) => x.toJson())),
    "assessment": List<dynamic>.from(assessment!.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 5)
class Lessons extends HiveObject {
  Lessons({
    this.title,
    this.time,
    this.image,
    this.code,
    this.status
  });

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? time;

  @HiveField(2)
  String? image;

  @HiveField(3)
  String? code;

  @HiveField(4)
  int? status;

  factory Lessons.fromJson(Map<String, dynamic> json) => Lessons(
    title: json["title"],
    time: json["time"],
    image: json["image"],
    code: json["code"],
    status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "time": time,
    "image": image,
    "code": code,
    "status": status
  };
}

@HiveType(typeId: 6)
class Assessment extends HiveObject {
  Assessment({
    this.title,
    this.time,
    this.image,
    this.code,
    this.status
  });

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? time;

  @HiveField(2)
  String? image;

  @HiveField(3)
  String? code;

  @HiveField(4)
  int? status;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
    title: json["title"],
    time: json["time"],
    image: json["image"],
    code: json["code"],
    status: json["json"]
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "time": time,
    "image": image,
    "code": code,
    "status": status
  };
}
