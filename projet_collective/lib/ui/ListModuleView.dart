import 'package:flutter/material.dart';

class ListModulesView extends StatelessWidget {
  const ListModulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Page des Modules (Page d\'accueil)')),
    );
  }
}