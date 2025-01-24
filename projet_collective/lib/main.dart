import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("The App Bar"), 
        ),
        body: const Center(
          child: Text("Home"), 
        ),
      ),
    );
  }
}

