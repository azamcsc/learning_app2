import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app2/constants/data.dart';
import 'package:learning_app2/constants/lesson_item.dart';
import 'package:readmore/readmore.dart';

import '../../constants/colors.dart';

class Topic2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson 2: Why it is important?'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: Lesson2().marginSymmetric(vertical: Get.height * 0.02),
        ),
      ),
    );
  }

  Column Lesson2() {
    return Column(
      children: [
        Center(
          child: Text(
            'Why we need to protect our Information?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.height * 0.025,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                  'Information must be secured so that it cannot be harvested by hackers for use in identity theft or other fraudulent schemes.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  'Making sure sensitive information like bank account and contact details are safe from fraud is another important aspect of data security.'),
            ],
          ).paddingAll(Get.width * 0.05),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Center(
          child: Text(
            'Threats of Information Protection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.height * 0.025,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                  '• Identity theft: is the act of posing as someone else in order to steal a person\'s personal information or essential information, such as accessing a person\'s computer or social media account by using their login credentials.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• Theft of equipment and information is on the rise these days Because of the mobile nature of gadgets and rising information capacity'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• Sabotage is described as ruining someone\'s social media or information in order to cause the individual to lose confidence.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  'Information extortion is using someone else\'s assets or information to get revenue. For instance, ransomware may lock victims\' files and demand money. After payment, victim info will be accessible.'),
            ],
          ).paddingAll(Get.width * 0.05),
        ),
      ],
    );
  }
}
