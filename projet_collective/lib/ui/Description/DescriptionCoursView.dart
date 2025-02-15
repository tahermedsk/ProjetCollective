import 'package:flutter/material.dart';

class DescriptionCoursView extends StatelessWidget {
  const DescriptionCoursView({Key? key, required String CoursId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Description Cours')),
      body: Center(
        child: Text('page Description  '),
      ),
    );
  }
}