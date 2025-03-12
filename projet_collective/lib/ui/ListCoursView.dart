// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:seriouse_game/models/ListCoursViewModel.dart';
import 'package:seriouse_game/ui/Cours/CoursView.dart';
import 'package:seriouse_game/ui/Cours/CoursViewModel.dart';

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

                  //Appel du widget affichant le titre
            	    titleWidget(module),

                  //Affiche description et objectif du module en gras à gauche
                  Align(
                    alignment: Alignment.centerLeft,
                    child :
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          child: 
                            const Text(
                              "Description et Objectif du Module",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              
                            ),
                      ),
                  ),

                  
                  
                  //Description du module

                  Align(
                    //Alignement du module de gauche à droite
                    alignment: Alignment.centerLeft,
                    child :
                      //Container pour définir les marges.
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        child: 
                          //Texte de la description
                          Text(module.description,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                        
                          )
                    ),
                  ),
                  

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
    //Valeur de la progression entre 0 et 1
    double progress = 0.5;
    return SizedBox(
      child : Container(
        //Gestion de l'espace entre le contenu et la bordure interieure du widget
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        //Gestion de l'espace entre l'exterieur du widget et les widgets adjacents
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
        //Décoration de la bordure
        decoration: BoxDecoration(
        //Gestion de l'angle de la bordure
        borderRadius:BorderRadius.circular(12),
        //Couleur interne et externe de la boite
        color: const Color.fromARGB(255, 236, 187, 139),),
        child : Row(
          children: [

            //Image à load

            Image.asset(
                'lib/data/AppData/facto-logo.png',
                height: 80, // Ajuste la hauteur
                fit: BoxFit.contain, // Garde les proportions
              ),

            const Spacer(),
            
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                
                //Affichage de la barre de progression du module
                //SizedBox est nécessaire car LinearProgressIndicator doit être contenue dans un objet de largeur définie
                //Column n'ayant pas de largeur max, on ne peut pas mettre le wwidget directement dedans
                SizedBox(
                  //Longueur max du widget
                  width: 200,
                  child:
                    //Container pour des bords plus arrondis
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      //Barre de progression du module
                      child: LinearProgressIndicator(
                          value: progress, //On utilise progress pour définir le remplissage
                          minHeight: 6,
                          color: const Color.fromARGB(255, 90, 230, 220),
                          backgroundColor: const Color.fromARGB(255, 175, 240, 235),
                        ),
                    ),
                )
                  
                
              ],
            ),
            
            const Spacer()
          ],
        ),
      )
    );
  }
  //Widget permettant d'afficher et de sélectionner un cours de la liste
  SizedBox listItem(Cours cours){
    
    return SizedBox(
      child : 
      //On utilise Inkwell pour transformer notre container en bouton
      InkWell(
        child: 
        Container(
          //Gestion de l'espace entre le contenu et la bordure interieure du widget
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          //Gestion de l'espace entre l'exterieur du widget et les widgets adjacents
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          //On utilise le header de CoursView
          child: HeaderWidget(cours: cours, coursViewModel: CoursViewModel())),
        //Méthode pour se aller au cours
        onTap: (){


        }
  
      ),
    );
  }
}