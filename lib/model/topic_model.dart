// To parse this JSON data, do
//
//     final topicModel = topicModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'topic_model.g.dart';

List<TopicModel> topicModelFromJson(String str) => List<TopicModel>.from(json.decode(str).map((x) => TopicModel.fromJson(x)));

String topicModelToJson(List<TopicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class TopicModel extends HiveObject {
  TopicModel({
    this.topic,
    this.title,
    this.overview,
    this.status,
  });

  @HiveField(0)
  int? topic;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? overview;

  @HiveField(3)
  int? status;

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    topic: json["topic"],
    title: json["title"],
    overview: json["overview"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "title": title,
    "overview": overview,
    "status": status,
  };
}
