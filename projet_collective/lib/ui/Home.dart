import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String nom;
  const Home({super.key, required this.nom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accueil - $nom")),
      body: Center(
        child: Text("Bienvenue sur la page $nom"),
      ),
    );
  }
}