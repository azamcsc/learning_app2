import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../model/details_model.dart';
import '../../model/topic_model.dart';
import '../../services/local_db_service.dart';

class TopicDetailsScreen extends StatefulWidget {
  final String subCode;
  final int topic;

  const TopicDetailsScreen(
      {Key? key, required this.subCode, required this.topic})
      : super(key: key);

  @override
  State<TopicDetailsScreen> createState() =>
      _TopicDetailsScreenState(subCode, topic);
}

class _TopicDetailsScreenState extends State<TopicDetailsScreen>
    with SingleTickerProviderStateMixin {
  String subCode;
  int? topic;

  _TopicDetailsScreenState(this.subCode, this.topic);

  final localDB = Get.find<LocalDBService>();
  RxBool detailLoading = false.obs;
  String detailJson = '';
  final detailList = <DetailsModel>[];
  final topicList = <TopicModel>[];

  @override
  void initState() {
    super.initState();
    getDetails();
    getTopic();
  }

  void getTopic() async {
    final String topicJson =
        await rootBundle.loadString('assets/json/topic.json');
    final topicData = await jsonDecode(topicJson);
    final topicModel = topicModelFromJson(jsonEncode(topicData["data"]));
    if (localDB.getTopic().isEmpty) {
      localDB.saveTopic(topicModel);
    }
    topicList.addAll(localDB.getTopic());
  }

  void getDetails() async {
    detailLoading(true);
    if (subCode == "SUB1") {
      detailJson = await rootBundle.loadString('assets/json/details_1.json');
    } else if (subCode == "SUB2") {
      detailJson = await rootBundle.loadString('assets/json/details_2.json');
    } else {
      detailJson = await rootBundle.loadString('assets/json/details_3.json');
    }
    final detailData = await jsonDecode(detailJson);
    final detailModel = detailsModelFromJson(jsonEncode(detailData["data"]));
    localDB.saveDetails(detailModel);
    detailLoading(false);
    detailList.addAll(localDB.getDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            title: detailLoading.isTrue
                ? Text('')
                : Text('${detailList.first.title}'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: detailLoading.isTrue
                ? CircularProgressIndicator()
                : Container(
                    margin: EdgeInsets.all(Get.width * 0.03),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: detailList.first.content!.length,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: EdgeInsets.only(top: Get.height * 0.01),
                              child: Column(
                                children: [
                                  Text(
                                    '${detailList.first.content![index].title}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Get.width * 0.05),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: detailList.first
                                          .content![index].description!.length,
                                      itemBuilder: (__, subIndex) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              bottom: Get.height * 0.02),
                                          child: Text(
                                              '${detailList.first.content![index].description![subIndex].desc}'),
                                        );
                                      },
                                    ).paddingAll(Get.width * 0.03),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                  if (topic == 1) {
                                    topicList[0].status = 1;
                                  } else if (topic == 2) {
                                    topicList[1].status = 1;
                                  } else {
                                    topicList[2].status = 1;
                                  }
                                },
                                child: Container(
                                  child: Text('Done Read'),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
          ));
    });
  }
}
