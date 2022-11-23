import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/screens2/Topics/TopicDetailsScreen.dart';
import 'package:learning_app2/screens2/Topics/Topic_Main.dart';
import 'package:learning_app2/screens2/Topics/Topics_screen.dart';
import 'package:learning_app2/screens2/home/widget/search_field.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              AppBar(),
              Body(),
              GridView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicScreen(
                                      topic: 123,
                                    )),
                          );
                        },
                        child: itemGrid(
                          "assets/icons/cyber-crime.png",
                          'Information Protection',
                          'Topic 1',
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicDetailsScreen(
                                      subCode: "213213",
                                      topic: 123,
                                    )), //edit this to topic screen/card
                          );
                        },
                        child: itemGrid("assets/icons/pass.png",
                            'Password Protection', 'Topic 2'),
                      );
                    }
                  }),
              GridView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.0,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicScreen(
                                      topic: 123,
                                    )),
                          );
                        },
                        child: itemGrid(
                          "assets/icons/chat-bubbles.png",
                          'Chat Safe',
                          'Topic 3',
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicDetailsScreen(
                                      subCode: "213213",
                                      topic: 123,
                                    )), //edit this to topic screen/card
                          );
                        },
                        child: itemGrid("assets/icons/chat-bubbles.png",
                            'Chat Safe', 'Topic 2'),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget itemGrid(String image, String title, String subtitle) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black38)
        ]),
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: kFont,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: kFont,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Topics',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TopicMainScreen()),
                    );
                  },
                  child: Text(
                    'See All',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kPrimary),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color.fromARGB(255, 66, 167, 240),
            Color.fromARGB(255, 67, 120, 255),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\nGood Day to you!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
