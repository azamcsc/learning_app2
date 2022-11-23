import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Topic3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson 3: Information Protection Countermeasure'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: Lesson3().marginSymmetric(vertical: Get.height * 0.02),
        ),
      ),
    );
  }

  Column Lesson3() {
    return Column(
      children: [
        Center(
          child: Text(
            'Countermeasure',
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
                  '• Use e-mail only for routine office communication: Never send sensitive information as e-mail. If e-mail absolutely must be used, encrypt the file and send it as an attachment rather than in the text of the e-mail message.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• Encrypt everything before it leaves your workstation: Even your password needs to be encrypted before leaving the workstation on its way to the network server-otherwise it could be intercepted as it travels network connections.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• Don\'t give out information about yourself like your name, house address and phone numbers to people that you meet on the internet.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• Don\'t send a picture of yourself, your friends or family to someone you met or chat with online.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• If somebody says something that worries you or want to send you something, ask your parents or someone elderly. Be alert to whatever they say, especially if the person is asking many personal questions.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• If you plan to meet someone that you have met on the Internet, take your parents or someone elderly with you. People in real life can be different from how they are online.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• Don\'t open up e-mails, files, or website links from people you don\'t really know.'),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                  '• Don\'t ever give your password to strangers. Never reveal any personal information, including that of your parents, through email, instant messaging, chat, or message boards, particularly if you are unsure. Keep in mind that not everyone you meet online will be who they claim to be. Even when someone claims to be a "12-year-old girl," they can really be a guy.'),
            ],
          ).paddingAll(Get.width * 0.05),
        ),
      ],
    );
  }
}
