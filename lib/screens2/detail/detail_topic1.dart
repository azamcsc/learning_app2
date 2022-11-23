import 'package:flutter/material.dart';

class DetailTopic1 extends StatelessWidget {
  final int index;

  DetailTopic1(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Text('The details page #$index'),
      ),
    );
  }
}
