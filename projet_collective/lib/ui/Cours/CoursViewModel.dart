import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seriouse_game/models/mediaCours.dart';
import 'package:video_player/video_player.dart';
import 'package:seriouse_game/repositories/mediaCoursRepository.dart';
import 'package:seriouse_game/repositories/pageRepository.dart';
import 'package:seriouse_game/models/cours.dart';

class CoursViewModel extends ChangeNotifier{
  CoursViewModel();

  int page = 0;

  final pageRepository = PageRepository();
  final mediaCoursRepository = MediaCoursRepository();

  Future<int> getNombrePageDeContenu(Cours cours) {
    return pageRepository.getPagesByCourseId(cours.id!).then((lstPage) {
      return lstPage.length;
    });
  }

  void setIndexPageVisite(Cours cours) {
    // Attention la page 0 est la page de description, pas la 1ère page de contenu
    pageRepository.getNbPageVisite(cours.id!).then( (indexPage) {
      page = indexPage;
      notifyListeners();
    });

  }

  void changementPageSuivante() {
    page++;
    // #TODO : Indiquer que la page a été vu dans la bdd
    notifyListeners();
  }

  void changementPagePrecedente() {
    if (page>0) {
      page--;
      notifyListeners();
    }
  }
  

  Future<void> loadContenu(Cours cours) async {
    // Récupération des pages associées au cours
    cours.pages = await pageRepository.getPagesByCourseId(cours.id!);
    print("Nombre de pages récupérées : \${cours.pages?.length}");

    // Parcours des pages pour récupérer les médias associés
    for (var page in cours.pages ?? []) {
      page.medias = await mediaCoursRepository.getByPageId(page.id!);
      print("Nombre de médias pour la page \${page.id} : \${page.medias?.length}");
    }
  }

}


