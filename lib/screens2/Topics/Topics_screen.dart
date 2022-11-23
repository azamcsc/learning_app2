import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_app2/screens2/Topics/TopicDetailsScreen.dart';
import 'package:learning_app2/screens2/Topics/Topic3.dart';
import 'package:learning_app2/screens2/assessments/assessments.dart';
import 'package:readmore/readmore.dart';
import '../../model/sub_topic_model.dart';
import '../../model/topic_model.dart';
import '../../services/local_db_service.dart';
import 'Topic2.dart';

class TopicScreen extends StatefulWidget {
  final int topic;

  const TopicScreen({Key? key, required this.topic}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState(topic);
}

class _TopicScreenState extends State<TopicScreen>
    with SingleTickerProviderStateMixin {
  int topic;

  _TopicScreenState(this.topic);

  final localDB = Get.find<LocalDBService>();
  RxBool subTopicLoading = false.obs;
  final subTopicList = <SubTopicModel>[];
  final topicList = <TopicModel>[];
  String subTopicJson = '';
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    getSubTopic();
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

  void getSubTopic() async {
    subTopicLoading(true);
    if (topic == 1) {
      subTopicJson = await rootBundle.loadString('assets/json/topic_1.json');
    } else if (topic == 2) {
      subTopicJson = await rootBundle.loadString('assets/json/topic_2.json');
    } else if (topic == 3) {
      subTopicJson = await rootBundle.loadString('assets/json/topic_3.json');
    } else if (topic == 4) {
      subTopicJson = await rootBundle.loadString('assets/json/topic_4.json');
    } else {
      subTopicJson = await rootBundle.loadString('assets/json/topic_5.json');
    }
    final subTopicData = await jsonDecode(subTopicJson);
    final subTopicModel =
        subTopicModelFromJson(jsonEncode(subTopicData["data"]));
    localDB.saveSubTopic(subTopicModel);
    subTopicLoading(false);
    subTopicList.addAll(localDB.getSubTopic());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: subTopicLoading.isTrue
                ? Text(
                    '',
                    textAlign: TextAlign.justify,
                  )
                : Text('${subTopicList.first.title}'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: subTopicLoading.isTrue
                ? CircularProgressIndicator()
                : Container(
                    height: Get.height,
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageHeader(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TopicTitle(),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Overview(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TabBar(
                          labelColor: Colors.blue,
                          labelPadding: EdgeInsets.all(Get.width * 0.04),
                          controller: tabController,
                          tabs: const [
                            Text('Lessons'),
                            Text('Assessment'),
                          ],
                        ),
                        TabView(),
                        Row(
                          children: [
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                if (topic == 1) {
                                  topicList[0].status = 2;
                                } else if (topic == 2) {
                                  topicList[1].status = 2;
                                } else {
                                  topicList[2].status = 2;
                                }
                              },
                              child: Container(
                                child: Text('Finish'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ));
    });
  }

  Expanded TabView() {
    return Expanded(
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: tabController,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: subTopicList.first.lessons!.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TopicDetailsScreen(
                            subCode: subTopicList.first.lessons![index].code!,
                            topic: topic,
                          )),
                ),
                child: Card(
                  color: Colors.grey.shade100,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 20,
                          child: Image.asset(
                              '${subTopicList.first.lessons![index].image}')),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Expanded(
                        flex: 75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${subTopicList.first.lessons![index].title}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                const Text(
                                  '15 minutes',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 5,
                        child: Icon(Icons.chevron_right),
                      )
                    ],
                  ).paddingAll(Get.width * 0.04),
                ),
              ).marginOnly(bottom: Get.height * 0.01);
            },
          ).marginSymmetric(vertical: Get.height * 0.01),
          ListView.builder(
            shrinkWrap: true,
            itemCount: subTopicList.first.assessment!.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssessmentScreen()),
                ),
                child: Card(
                  color: Colors.grey.shade100,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 20,
                          child: Image.asset(
                              '${subTopicList.first.assessment![index].image}')),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Expanded(
                        flex: 75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${subTopicList.first.assessment![index].title}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                const Text(
                                  '15 minutes',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 5,
                        child: Icon(Icons.chevron_right),
                      )
                    ],
                  ).paddingAll(Get.width * 0.04),
                ),
              ).marginOnly(bottom: Get.height * 0.01);
            },
          ).marginSymmetric(vertical: Get.height * 0.01),
        ],
      ),
    );
  }

  Column Overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: Get.height * 0.02),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        ReadMoreText(
          '${subTopicList.first.overview}   ',
          trimLines: 1,
          textAlign: TextAlign.justify,
          colorClickableText: Colors.blue,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show More',
          trimExpandedText: 'Show Less',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Column TopicTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Topic ${subTopicList.first.topic}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: Get.height * 0.02),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          children: [
            const Icon(
              Icons.play_circle_outline,
              color: Colors.grey,
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Text(
              '${subTopicList.first.lessons!.length} lessons',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.question_mark,
              color: Colors.grey,
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Text(
              '${subTopicList.first.assessment!.length} assessment',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container ImageHeader() => Container(
        color: Colors.white,
        child: Center(
            child: Image.asset(
          'assets/images/Chit.jpg',
          width: Get.width * 0.7,
        )),
      );
}
