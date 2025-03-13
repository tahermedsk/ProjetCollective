import 'package:flutter/material.dart';
import 'package:seriouse_game/models/module.dart';
import 'package:seriouse_game/ui/ListCoursView.dart';
import 'package:seriouse_game/ui/ModuleSelectionne.dart';

import '../models/ListModuleViewModel.dart';

import 'package:go_router/go_router.dart';

class ListModulesView extends StatefulWidget {

  const ListModulesView({super.key});

  @override
  State<ListModulesView> createState() => _ListModulesViewState();
}

class _ListModulesViewState extends State<ListModulesView> {

  ListModuleViewModel listModuleViewModel = ListModuleViewModel();

  @override
  Widget build(BuildContext context) {

    listModuleViewModel.recupererModule();

    return ListenableBuilder(

      listenable: listModuleViewModel,

      builder: (context,child) {

        return Column(
        
        
          children: [
        
            //Affiche Overview en gras à gauche
            Align(
              alignment: Alignment.centerLeft,
              child :
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: 
                    const Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                                  
                    ),
                ),
            ), 
        
            headerAvancement(), 

            //Affiche Modules en gras à gauche
            Align(
              alignment: Alignment.centerLeft,
              child :
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: 
                    const Text(
                      "Modules :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                                  
                    ),
                ),
            ), 
        
            //Affichage de la liste des modules
                      
            Expanded(
              child:
              ListView.builder(
        
                //On initialise le nombre de widgets à affiché par celui de la liste des modules
                itemCount: listModuleViewModel.listModule.length,
        
                itemBuilder: (context, index) {
                  //On extraie pour chaque élément de la liste le module dans item
                  final item = listModuleViewModel.listModule[index];
        
                  //On build le widget à partir d'item
                  return listModuleItem(item, context);
                },
              ),
            ),   
        
          ],  
        );
      }
    );

  }
}

SizedBox listModuleItem(Module item, BuildContext context) {

  return SizedBox(
      child : 
      //On utilise Inkwell pour transformer notre container en bouton
      InkWell(
        child: 
          moduleHeader(item),        
        //Méthode pour aller au module
        onTap: (){

          ModuleSelectionne.instance.moduleSelectionne = item;
          GoRouter.of(context).go('/cours');
        }
      ),
    );
}

SizedBox headerAvancement(){

  return const SizedBox(
    child: Text("Votre Avancement"),
  );

}