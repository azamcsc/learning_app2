// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'question_model.g.dart';

List<QuestionModel> questionModelFromJson(String str) => List<QuestionModel>.from(json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questionModelToJson(List<QuestionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class QuestionModel extends HiveObject {
  QuestionModel({
    this.id,
    this.flag,
    this.question,
    this.ans,
    this.options,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  int? flag;

  @HiveField(2)
  String? question;

  @HiveField(3)
  dynamic ans;

  @HiveField(4)
  List<Option>? options;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["id"],
    flag: json["flag"],
    question: json["question"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "flag": flag,
    "question": question,
    "options": List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 1)
class Option extends HiveObject {
  Option({
    this.oid,
    this.desc,
    this.mark,
    this.index,
  });

  @HiveField(0)
  String? oid;

  @HiveField(1)
  String? desc;

  @HiveField(2)
  int? mark;

  @HiveField(3)
  int? index;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    oid: json["oid"],
    desc: json["desc"],
    mark: json["mark"],
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "oid": oid,
    "desc": desc,
    "mark": mark,
    "index": index,
  };
}
