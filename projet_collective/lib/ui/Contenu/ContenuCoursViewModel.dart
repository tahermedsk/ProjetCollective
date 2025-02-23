import 'package:seriouse_game/models/mediaCours.dart';
import 'package:video_player/video_player.dart';
import 'package:seriouse_game/repositories/mediaCoursRepository.dart';
import 'package:seriouse_game/repositories/pageRepository.dart';
import 'package:seriouse_game/models/cours.dart';

class ContenuCoursViewModel {
  ContenuCoursViewModel();

  final pageRepository = PageRepository();
  final mediaCoursRepository = MediaCoursRepository();

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

  VideoPlayerController VideoLoader(MediaCours mediaModel){

      late VideoPlayerController controller;

      try {
        
        
        controller = VideoPlayerController.asset(mediaModel.url);
        
        
      } on Exception catch (e) {
        rethrow;
      }

      return controller ;

  }

  String? imageLoader(MediaCours data) {
    if (data.type == "image") {
      return data.url; // Retourne le chemin du fichier image
    }
    return null; // Retourne null si ce n'est pas une image
  }
}


