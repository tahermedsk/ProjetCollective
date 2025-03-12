import 'package:flutter/material.dart';

class ListCoursView extends StatelessWidget {
  const ListCoursView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modules')),
      body: const Center(child: Text('Page des Cours du module sélectionné')),
    );
  }
}