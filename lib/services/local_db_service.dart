import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:learning_app2/model/details_model.dart';
import 'package:learning_app2/model/sub_topic_model.dart';
import 'package:learning_app2/model/topic_model.dart';
import '../model/question_model.dart';
import 'local_db_constant.dart';

class LocalDBService extends GetxService {

  @override
  void onInit() {
    super.onInit();
  }

  Future<LocalDBService> initService() async {
    await Hive.openBox(DBConstant.dbName);
    print('xxxx LOCAL DB INITIALIZED' );
    return this;
  }

  void saveQuestion(List<QuestionModel>? data) {
    Hive.box(DBConstant.dbName).put(DBConstant.KEY_QUESTION_LIST, data);
    return;
  }
  void saveTopic(List<TopicModel>? data) {
    Hive.box(DBConstant.dbName).put(DBConstant.KEY_TOPIC, data);
    return;
  }
  void saveSubTopic(List<SubTopicModel>? data) {
    Hive.box(DBConstant.dbName).put(DBConstant.KEY_SUB_TOPIC, data);
    return;
  }
  void saveDetails(List<DetailsModel>? data) {
    Hive.box(DBConstant.dbName).put(DBConstant.KEY_DETAIL, data);
    return;
  }

  List<QuestionModel> getQuestion() {
    return Hive.box(DBConstant.dbName).get(DBConstant.KEY_QUESTION_LIST, defaultValue: []).cast<QuestionModel>();
  }
  List<TopicModel> getTopic() {
    return Hive.box(DBConstant.dbName).get(DBConstant.KEY_TOPIC, defaultValue: []).cast<TopicModel>();
  }
  List<SubTopicModel> getSubTopic() {
    return Hive.box(DBConstant.dbName).get(DBConstant.KEY_SUB_TOPIC, defaultValue: []).cast<SubTopicModel>();
  }
  List<DetailsModel> getDetails() {
    return Hive.box(DBConstant.dbName).get(DBConstant.KEY_DETAIL, defaultValue: []).cast<DetailsModel>();
  }

}
