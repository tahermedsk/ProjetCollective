import 'dart:async';

import 'package:flutter/services.dart';
import 'package:seriouse_game/models/QCM/qcm.dart';
import 'package:seriouse_game/models/QCM/question.dart';
import 'package:seriouse_game/models/QCM/reponse.dart';
import 'package:seriouse_game/models/cours.dart';
import 'package:seriouse_game/repositories/QCM/QCMRepository.dart';



 
class JeuQCMViewModel {
  Future<Map<String, dynamic>> recupererQCM(Cours cours, int selectedPageIndex) async {
    try {
      final qcmRepo = QCMRepository();
      List<int> idQCMList = await qcmRepo.getAllIdByCoursId(cours.id!);
      QCM? qcm = await qcmRepo.getById(idQCMList[selectedPageIndex]);
      
      Question? questions;
      List<Reponse>? reponses = [];
      int? solutions;
      
      questions = qcm!.question;
      reponses = qcm!.reponses;
      solutions = qcm!.numSolution;
      
      return {
        "question": questions,
        "options": reponses,
        "correctAnswer": solutions,
      };
    
    } catch (e) {
      print("Erreur lors du chargement du QCM : $e");
      return {};
    }
  }
}

   