import 'package:flutter/material.dart';

import 'screens/login_page.dart';


import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:hive/hive.dart';
import 'package:learning_app2/model/details_model.dart';
import 'package:learning_app2/model/question_model.dart';
import 'package:learning_app2/model/sub_topic_model.dart';
import 'package:learning_app2/screens2/welcome/welcome_screen.dart';
import 'package:learning_app2/services/local_db_service.dart';
import 'package:path_provider/path_provider.dart';

import 'model/topic_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(!GetPlatform.isWeb){
    final document = await getApplicationDocumentsDirectory();
    Hive
      ..init(document.path)
      ..registerAdapter(QuestionModelAdapter())
      ..registerAdapter(OptionAdapter())
      ..registerAdapter(TopicModelAdapter())
      ..registerAdapter(SubTopicModelAdapter())
      ..registerAdapter(LessonsAdapter())
      ..registerAdapter(AssessmentAdapter())
      ..registerAdapter(DetailsModelAdapter())
      ..registerAdapter(ContentAdapter())
      ..registerAdapter(DescriptionAdapter());
  }
  await Get.putAsync(()=>LocalDBService().initService(), permanent: true);

  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 24.0,
            ),
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 46.0,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w500,
          ),
          bodyText1: TextStyle(fontSize: 18.0),
        ),
      ),
      home: LoginPage(),
    );
  }
}*/


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      home: LoginPage(),//WelcomeScreen(),
      //home: HomePage(),
      debugShowCheckedModeBanner: true,
    );
  }
}