import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_app2/constants/colors.dart';
import 'package:learning_app2/screens2/detail/detail_topic1.dart';

class LessonItem extends StatelessWidget {
  LessonItem({Key? key, required this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: Offset(1, 1))
          ]),
      child: Row(
        children: [
          Image.asset(
            data["image"],
            width: 70,
            height: 70,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["name"],
                style: TextStyle(
                    color: kFont, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.schedule_outlined,
                    color: kPrimaryLight,
                    size: 18,
                  ),
                  Text(
                    data["duration"],
                    style: TextStyle(color: kPrimaryDark, fontSize: 14),
                  ),
                ],
              )
            ],
          )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailTopic1(1)),
                );
              },
              icon: Icon(Icons.navigate_next))
        ],
      ),
    );
  }
}
