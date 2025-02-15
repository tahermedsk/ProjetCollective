import 'package:flutter/material.dart';

class ContenuCoursView extends StatelessWidget {
  const ContenuCoursView({Key? key, required String CoursId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contenu Cours')),
      body: Center(
        child: Text(' page Cours '),
      ),
    );
  }
}