import 'package:flutter/material.dart';
import 'package:seriouse_game/repositories/coursRepository.dart';
import 'package:seriouse_game/ui/ModuleSelectionne.dart';

//Classe permettant d'extraire les cours d'un module 
class ListCoursViewModel with ChangeNotifier {

  //Méthode pour changer la liste coursDuModule du Singleton ModuleSelectionne par celle correspondant à la liste des cours du module d'id idModule
  Future<void> recupererCours(int? idModule) async {

    CoursRepository repository = CoursRepository();

    //On accède à la liste des cours de la base de donnée par la méthode de CoursRepository
    ModuleSelectionne().updateListModule(await repository.getCoursesByModuleId(idModule!));

    //la liste change donc  on avertit les listeners
    notifyListeners();
  }
  

}