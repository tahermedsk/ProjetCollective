import 'package:seriouse_game/repositories/pageRepository.dart';

class ProgressionUseCase {
  final PageRepository pageRepository;

  ProgressionUseCase({required this.pageRepository});

  // Méthode pour récupérer le pourcentage de pages vues pour un cours donné en passant l'ID du cours en paramètre
  Future<double> getPourcentagePagesVues(int coursId) async {
    try {
      // Récupération du nombre total de pages pour le cours
      final totalPages = await pageRepository.getNbPageByCourseId(coursId);

      // Récupération du nombre de pages vues pour le cours
      final pagesVues = await pageRepository.getNbPageVisite(coursId);

      // Calcul du pourcentage de pages vues
      final pourcentage = (pagesVues / totalPages) * 100;

      return pourcentage;
    } catch (e) {
      print("Erreur lors du calcul du pourcentage de pages vues : $e");
      return 0;
    }
  }
}
