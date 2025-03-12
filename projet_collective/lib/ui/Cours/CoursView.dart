import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:seriouse_game/ui/Cours/CoursViewModel.dart';
import 'package:seriouse_game/ui/Description/DescriptionView.dart';
import 'package:seriouse_game/ui/Contenu/ContenuCoursView.dart';

import 'package:seriouse_game/ui/CoursSelectionne.dart';
import 'package:seriouse_game/models/cours.dart';
import 'package:seriouse_game/repositories/coursRepository.dart';

class CoursView extends StatelessWidget {
  CoursView({super.key}) {
    // MAJ du ViewModel avec le nouveau cours séléctionné
    CoursSelectionne coursSelectionne = CoursSelectionne.instance;
    coursViewModel.loadContenu(coursSelectionne.cours);  // #TODO : A mettre dans ListCours.dart
    coursViewModel.setIndexPageVisite(coursSelectionne.cours);
  }

  Widget? child;
  
  final coursViewModel = CoursViewModel(); // #TODO : A tester

  Future<void> changePage() async {
    CoursSelectionne coursSelectionne = CoursSelectionne.instance;

    int nbPageCours = await coursViewModel.getNombrePageDeContenu(coursSelectionne.cours);
    int page = coursViewModel.page;

    Widget nouvellePage = const Text("PB lors du chargement de la page de cours");
    if (page==0) {
      nouvellePage = const DescriptionView();
      //print("Chargement de description");
    } else if (page<=nbPageCours) {

      nouvellePage = ContenuCoursView(cours: coursSelectionne.cours, selectedPageIndex: page - 1);
      //print("Chargement de contenu");
    } else {
      // Page jeu 
    }

    child = nouvellePage;
  }

  @override
  Widget build(BuildContext context) {

    return ListenableBuilder(
          listenable: coursViewModel,
          builder: (context, _) {
            // Le futur Builder sert à attendre l'exécution de la méthode changePage() avant de build :
            // Sans, la page à afficher (ie this.child) est récupéré après le build : 
            //            Il n'est donc pas affiché
            return FutureBuilder<void>(
              future: changePage(), // Récupération de la bonne View à charger selon la page visitée du cours sélectionné
              builder: (context, snapshot) {

                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 2,
                        title: HeaderWidget(),
                        centerTitle: false,
                      ),
                      body: child,
                      bottomNavigationBar: FooterWidget(
                        courseTitle: "Cours 1",
                        pageNumber: 1,
                        coursViewModel: coursViewModel,
                      ), 
                    );
              }
            );
          }
    );

  }
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        // Titre
        Text(
          'Cours 1',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // Barre de progression
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.5, // Progression à 50%
              minHeight: 6,
              color: Colors.teal,
              backgroundColor: Colors.teal.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
}

class FooterWidget extends StatelessWidget {
  final String courseTitle;
  final int pageNumber;

  final CoursViewModel coursViewModel;

  const FooterWidget({
    Key? key,
    required this.courseTitle,
    required this.pageNumber,
    required this.coursViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton flèche gauche
          IconButton(
            icon: const Icon(Icons.arrow_left, size: 28),
            onPressed: () {
              // Action pour aller à la page précédente
              coursViewModel.changementPagePrecedente();
            },
          ),
          // Texte de pagination
          Text(
            '$courseTitle : Page $pageNumber',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Bouton flèche droite
          IconButton(
            icon: const Icon(Icons.arrow_right, size: 28),
            onPressed: () {
              // Action pour aller à la page suivante
              coursViewModel.changementPageSuivante();
            },
          ),
        ],
      ),
    );
  }
}