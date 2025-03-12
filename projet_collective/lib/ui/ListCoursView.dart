// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:seriouse_game/models/ListCoursViewModel.dart';

import '../models/cours.dart';
import '../models/module.dart';
import 'ModuleSelectionne.dart';

class ListCoursView extends StatefulWidget {

  ListCoursViewModel listCours = ListCoursViewModel();
  ModuleSelectionne moduleSelectionne = ModuleSelectionne();

  ListCoursView({super.key});

  @override
  State<ListCoursView> createState() => ListCoursViewState(listCours,moduleSelectionne);
  
}

class ListCoursViewState extends State<ListCoursView>{

  late ListCoursViewModel listCours;
  late ModuleSelectionne moduleSelectionne;

  ListCoursViewState(this.listCours,this.moduleSelectionne);


  @override
  Widget build(BuildContext context) {
    
    return ListenableBuilder(

    //On écoute moduleSelectionne pour changer l'interface si le module change.
    listenable: moduleSelectionne,
    builder: (context, child) {


        int size = 0;

        // Récupération du module sélectionné
        Module module = moduleSelectionne.moduleSelectionne;

        // Chargement des cours associés dans le module
        listCours.recupererCours(module.id);

        //récupération de la taille de la liste du module
        size = moduleSelectionne.coursDuModule.length;
      
        //Widget
        return ListenableBuilder(

            //On écoute l'état de listCours pour changer l'affichage si cette liste change
            listenable: listCours,

            builder: (context, child) {


            	return Column(
            	  children: [

                  //Appel du widget affichant un titre
            	    titleWidget(module),

                  const Text("Description et Objectif du Module"),
                  
                  //Description du module
                  Text(module.description),

                  //Affichage de la liste des cours du module
                  
                  Expanded(
                    child:
                      ListView.builder(

                      //On initialise le nombre de widgets à affiché par celui de la liste de cours
                      itemCount: size,

                      itemBuilder: (context, index) {
                        //On extraie pour chaque élément de la liste le cours dans item
                        final item = moduleSelectionne.coursDuModule[index];

                        //On build le widget à partir du titre d'item
                        return listItem(item);
                      },
                      ),
                  ),  
            	  ],
            	);// Widgets de liste avec données

            }
          );
        }
      );
    }

  //Widget correspondant au titre du module
  SizedBox titleWidget(Module module){
    //Valeur de la progression
    double progress = 0.5;
    return SizedBox(
      child : Container(
        //Gestion de l'espace entre le contenu et la bordure interieure du widget
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        //Gestion de l'espace entre l'exterieur du widget et les widgets adjacents
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        //Décoration de la bordure
        decoration: BoxDecoration(
        //Gestion de l'angle de la bordure
        borderRadius:BorderRadius.circular(10),
        //Couleur interne et externe de la boite
        color: const Color.fromARGB(255,232,165,99),),
        child : Row(
          children: [

            //Image à load

            Image.asset(
                'lib/data/AppData/facto-logo.png',
                height: 80, // Ajuste la hauteur
                fit: BoxFit.contain, // Garde les proportions
              ),

            
            Column(
              //Titre du module
              children: [
                Container(
                  //Gestion de l'espace entre le contenu et la bordure interieure du widget
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  //Gestion de l'espace entre l'exterieur du widget et les widgets adjacents
                  margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Text(module.titre,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                //Affichage de la barre de progression du module

                /*
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress, 
                      minHeight: 6,
                      color: Colors.teal,
                      backgroundColor: Colors.teal.withOpacity(0.2),
                    ),
                  ),*/
              ],
            ),
            
            
          ],
        ),
      )
    );
  }
  //Widget permettant d'afficher et de sélectionner un cours de la liste
  SizedBox listItem(Cours cours){
    
    return SizedBox(
      child : Text(cours.titre),
    );
  }
}