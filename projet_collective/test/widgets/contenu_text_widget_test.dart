import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuImageWidget.dart';


void main() {
  testWidgets('Affiche correctement le contenu d\'un fichier texte', (WidgetTester tester) async {
    final tempDir = Directory.systemTemp; // Crée un répertoire temporaire
    final tempFile = File('${tempDir.path}/test_file.txt');

    await tempFile.writeAsString('Ceci est un test. \n Si cela s\'affiche, alors le widget d\'image fonctionne');

    // Construire le widget et déclencher un rendu
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ContenuTextWidget(filePath: tempFile.path),
      ),
    ));

    // Vérifier que le CircularProgressIndicator s'affiche au départ
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Avancer le temps pour afficher le contenu du fichier
    await tester.pumpAndSettle();

    // Vérifier que le texte du fichier est affiché
    expect(find.text('Ceci est un test. \n Si cela s\'affiche, alors le widget d\'image fonctionne'), findsOneWidget);

    // Nettoyer le fichier temporaire
    tempFile.deleteSync();
  });

  testWidgets('Affiche un message d\'erreur si le fichier est introuvable', (WidgetTester tester) async {
    // Construire le widget avec un chemin de fichier invalide
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ContenuTextWidget(filePath: 'invalid_path.txt'),
      ),
    ));

    // Vérifier que le CircularProgressIndicator s'affiche au départ
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Avancer le temps pour afficher l'état d'erreur
    await tester.pumpAndSettle();

    // Vérifier que le message d'erreur s'affiche
    expect(find.text('Erreur : Impossible de lire le fichier.'), findsOneWidget);
  });
}
