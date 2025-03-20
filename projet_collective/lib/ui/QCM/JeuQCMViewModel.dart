import 'dart:async';

import 'package:flutter/services.dart';
import 'package:seriouse_game/ui/CoursSelectionne.dart';
 
class JeuQCMViewModel {
  Future<Map<String, dynamic>> recupererQCM(int idQCM, int selectedPageIndex) async {
    try {
      // Récupérer la question depuis un fichier texte
      print(selectedPageIndex);
      String question = "Quoi ?";//await rootBundle.loadString('lib/data/qcm/$idQCM/question.txt');
      if (question.isEmpty) {
       throw Exception("Le fichier question.txt est vide ou absent.");
      }

      // Vérifier si les réponses sont des textes ou des images
      List<String> options = [];
      for (int i = 1; i <= 4; i++) {
        String textPath = 'lib/data/qcm/$idQCM/reponse$i.txt';
        options.add("feur$i");
        //String imagePath = 'lib/data/qcm/$idQCM/reponse$i.png';
        /*
         if (await rootBundle.loadString(textPath).then((value) => value.isNotEmpty)) {
          options.add(await rootBundle.loadString(textPath));
        } else if (await rootBundle.loadString(imagePath).then((value) => value.isNotEmpty)) {
          options.add(imagePath); // On stocke juste le chemin de l'image
        } else {
          throw Exception("Réponse $i introuvable.");
        }*/
      }

      // Récupérer l'indice de la bonne réponse
      //String indiceStr = await rootBundle.loadString('lib/data/qcm/$idQCM/solution.txt');
      String indiceStr = "2";
      int correctAnswer = int.tryParse(indiceStr.trim()) ?? -1;
      if (correctAnswer < 1 || correctAnswer > 4) {
        throw Exception("Indice de réponse invalide.");
      }

      return {
        "question": question,
        "options": options,
        "correctAnswer": correctAnswer,
      };
    } catch (e) {
      print("Erreur lors du chargement du QCM : $e");
      return {};
    }
  }
}