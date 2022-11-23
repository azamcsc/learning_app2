import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_app2/model/topic_model.dart';
import 'package:learning_app2/screens2/Topics/Topics_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../services/local_db_service.dart';

class TopicMainScreen extends StatefulWidget {
  const TopicMainScreen({Key? key}) : super(key: key);

  @override
  State<TopicMainScreen> createState() => _TopicMainScreenState();
}

class _TopicMainScreenState extends State<TopicMainScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final localDB = Get.find<LocalDBService>();
  int selectedIndex = 1;
  RxBool topicLoading = false.obs;
  final topicList = <TopicModel>[];
  final topicListProgress = <TopicModel>[];
  final topicListCompleted = <TopicModel>[];

  @override
  void initState() {
    super.initState();
    getTopic();
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    topicList.clear();
    topicListProgress.clear();
    topicListCompleted.clear();
    topicList.addAll(localDB.getTopic());
    topicListProgress.addAll(localDB.getTopic());
    topicListCompleted.addAll(localDB.getTopic());
    setState(() {
      topicList.removeWhere((element) => element.status != 0);
      topicListProgress.removeWhere((element) => element.status != 1);
      topicListCompleted.removeWhere((element) => element.status != 2);
    });
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  void getTopic() async {
    topicLoading(true);
    final String topicJson =
        await rootBundle.loadString('assets/json/topic.json');
    final topicData = await jsonDecode(topicJson);
    final topicModel = topicModelFromJson(jsonEncode(topicData["data"]));
    if (localDB.getTopic().isEmpty) {
      localDB.saveTopic(topicModel);
    }
    topicLoading(false);
    topicList.addAll(localDB.getTopic());
    print(topicModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              Container(
                  height: Get.height,
                  child: SmartRefresher(
                      controller: refreshController,
                      header: WaterDropHeader(),
                      onRefresh: onRefresh,
                      onLoading: onLoading,
                      child: Body())),
            ],
          ),
        ));
  }

  Container Header() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
        color: Colors.blue.shade300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * 0.05),
          Text(
            'My Topics',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedIndex == 1
                        ? Colors.grey.shade200
                        : Colors.transparent,
                  ),
                  child: Text(
                    'All',
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedIndex == 2
                        ? Colors.grey.shade200
                        : Colors.transparent,
                  ),
                  child: Text(
                    'In Progress',
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedIndex == 3
                        ? Colors.grey.shade200
                        : Colors.transparent,
                  ),
                  child: Text(
                    'Completed',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  LayoutBuilder Body() {
    return LayoutBuilder(
      builder: (_, constraints) {
        switch (selectedIndex) {
          case 1:
            return All();
          case 2:
            return InProgress();
          case 3:
            return Completed();
          default:
            return All();
        }
      },
    );
  }

  Obx All() {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        child: topicLoading.isTrue
            ? CircularProgressIndicator()
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: topicList.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TopicScreen(topic: topicList[index].topic!)));
                    },
                    child: topicList[index].status == 0
                        ? Container(
                            padding: EdgeInsets.all(Get.width * 0.03),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Topic ${topicList[index].topic}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width * 0.05,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text('${topicList[index].title}'),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Text(
                                  '${topicList[index].overview}',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                )
                              ],
                            ),
                          )
                        : Container(),
                  );
                },
              ),
      );
    });
  }

  Container InProgress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: topicLoading.isTrue
          ? CircularProgressIndicator()
          : GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: topicListProgress.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TopicScreen(
                                topic: topicListProgress[index].topic!)));
                  },
                  child: topicListProgress[index].status == 1
                      ? Container(
                          padding: EdgeInsets.all(Get.width * 0.03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Topic ${topicListProgress[index].topic}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width * 0.05,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text('${topicListProgress[index].title}'),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                '${topicListProgress[index].overview}',
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              )
                            ],
                          ),
                        )
                      : Container(),
                );
              },
            ),
    );
  }

  Container Completed() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: topicLoading.isTrue
          ? CircularProgressIndicator()
          : GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: topicListCompleted.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TopicScreen(
                                topic: topicListCompleted[index].topic!)));
                  },
                  child: topicListCompleted[index].status == 2
                      ? Container(
                          padding: EdgeInsets.all(Get.width * 0.03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Topic ${topicListCompleted[index].topic}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width * 0.05,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text('${topicListCompleted[index].title}'),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                '${topicListCompleted[index].overview}',
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              )
                            ],
                          ),
                        )
                      : Container(),
                );
              },
            ),
    );
  }
}
