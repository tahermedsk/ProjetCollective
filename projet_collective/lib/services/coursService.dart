import '../models/cours.dart';
import '../models/objectifCours.dart';
import '../repositories/coursRepository.dart';
import '../repositories/objectifCoursRepository.dart';

class CoursService {
  final CoursRepository _coursRepository = CoursRepository();
  final ObjectifCoursRepository _objectifRepository = ObjectifCoursRepository();

  // Récupérer un cours et lui ajouter ses objectifs
  Future<Cours?> getCoursWithObjectifs(int coursId) async {
    // Récupérer le cours par ID
    final cours = await _coursRepository.getById(coursId);
    if (cours == null) return null;

    // Récupérer les objectifs associés au cours
    final objectifs = await _objectifRepository.getByCoursId(coursId);

    // Ajouter les objectifs au cours
    cours.objectifs = objectifs;

    return cours;
  }
}
