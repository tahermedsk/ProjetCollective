import 'package:flutter/material.dart';
import 'package:seriouse_game/models/cours.dart';
import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuImageWidget.dart';
import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuVideoWidget.dart';
import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuTextWidget.dart';
import 'package:seriouse_game/ui/Contenu/ContenuCoursViewModel.dart';

class ContenuCoursView extends StatelessWidget {
  final Cours cours;
  final int selectedPageIndex; // Nouvelle propriété pour choisir la page

  const ContenuCoursView({
    super.key, 
    required this.cours, 
    required this.selectedPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    // Vérifier que l'index est valide
    if (cours.pages == null || selectedPageIndex < 0 || selectedPageIndex >= cours.pages!.length) {
      print("Page introuvable");
      return const Center(child: Text("Page introuvable"));
    }

    var page = cours.pages![selectedPageIndex];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: page.medias?.map((media) {
          print("Media url: ${media.url}");

          if (media.type == "image") {
            return ContenuImageWidget(media: media);
          } else if (media.type == "video") {
              return ContenuVideoWidget(data: media);
          } else if (media.type == "text") {
            return ContenuTextWidget(filePath: media.url);
          } else {
            return const SizedBox(); // Cas inconnu
          }
        }).toList() ?? [],
      ),
    );
  }
}