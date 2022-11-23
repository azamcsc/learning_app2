import 'package:flutter/material.dart';
import 'package:learning_app2/screens2/home/featured_screen.dart';

import '../Topics/Topic_Main.dart';
import '../setting/setting.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  List pages = [
    FeaturedScreen(),
    TopicMainScreen(),
    SettingScreen(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    FeaturedScreen(),
    FeaturedScreen(),
    FeaturedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              "assets/icons/homeColor.png",
              height: 20,
            ),
            icon: Image.asset(
              "assets/icons/homeBlack.png",
              height: 20,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                "assets/icons/topicColor.png",
                height: 20,
              ),
              icon: Image.asset(
                "assets/icons/topicBlack.png",
                height: 20,
              ),
              label: "Topics"),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                "assets/icons/settingColor.png",
                height: 20,
              ),
              icon: Image.asset(
                "assets/icons/settingBlack.png",
                height: 20,
              ),
              label: "Settings"),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
