import 'package:flutter/material.dart';

class Module extends StatelessWidget {
  final String nom;
  const Module({super.key, required this.nom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Module - $nom")),
      body: Center(
        child: Text("Contenu du module $nom"),
      ),
    );
  }
}