import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_app2/model/question_model.dart';
import 'package:learning_app2/services/local_db_service.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({Key? key}) : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {

  final localDB = Get.find<LocalDBService>();
  PageController pageController = PageController();
  final questionList = <QuestionModel>[];
  RxBool questionLoading = false.obs;
  int selectedOptions = 5;
  int selectedPages = 100;

  @override
  void initState() {
    super.initState();
    getQuestionData();
  }

  void getQuestionData() async {
    try {
      questionLoading(true);
      final String json =
          await rootBundle.loadString('assets/json/assessment.json');
      final data = await jsonDecode((json));
      final questionModel = questionModelFromJson(jsonEncode(data["data"]));
      localDB.saveQuestion(questionModel);
      questionLoading(false);
      questionList.addAll(localDB.getQuestion());
    } catch (error) {
      questionLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text('Assessment'),
          centerTitle: true,
        ),
        body: questionLoading.isTrue
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                color: Colors.black,
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: questionList.length,
                  controller: pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(Get.width * 0.05),
                      child: Column(
                        children: [
                          Text(
                            'Q${questionList[index].id}. ${questionList[index].question}',
                            style: TextStyle(color: Colors.white),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: questionList[index].options!.length,
                              itemBuilder: (BuildContext _, int oindex) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedOptions = oindex;
                                      questionList[index].flag = 1;
                                      questionList[index].ans = oindex;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(Get.width * 0.05),
                                    margin:
                                        EdgeInsets.only(top: Get.height * 0.02),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      color: questionList[index].flag == 1 ? questionList[index].ans == oindex ? questionList[index].options![oindex].mark == 1 ? Colors.green : Colors.red : Colors.transparent : Colors.transparent,
                                    ),
                                    child: Text(
                                      '${questionList[index].options![oindex].oid}. ${questionList[index].options![oindex].desc}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          Spacer(),
                          Row(
                            children: [
                              index == 0 ?
                                  Container() :
                              IconButton(
                                  onPressed: () {
                                    pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                              ),
                              Spacer(),
                              index == questionList.length-1 ?
                              ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Container(
                                    child: Text(
                                      'Done'
                                    ),
                                  )
                              ) :
                              IconButton(
                                onPressed: () {
                                  pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
      );
    });
  }
}
