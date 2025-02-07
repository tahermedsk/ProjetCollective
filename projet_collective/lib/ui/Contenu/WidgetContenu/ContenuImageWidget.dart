import 'dart:io';

import 'package:flutter/material.dart';

class ContenuTextWidget extends StatelessWidget {
  final String filePath; // Chemin local du fichier texte

  ContenuTextWidget({required this.filePath});

  // Fonction pour charger le texte depuis un fichier local
  Future<String> _loadTextFromFile(String filePath) async {
    final file = File(filePath);
    return await file.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadTextFromFile(filePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erreur : Impossible de lire le fichier.',
              style: const TextStyle(color: Color.fromRGBO(252, 179, 48, 1)),
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              snapshot.data ?? '',
              style: const TextStyle(fontSize: 16.0, height: 1.5),
            ),
          );
        }
      },
    );
  }
}
