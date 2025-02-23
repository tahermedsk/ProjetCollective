import 'package:flutter/material.dart';
import 'package:seriouse_game/models/cours.dart';
import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuImageWidget.dart';
import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuVideoWidget.dart';
import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuTextWidget.dart';
import 'package:seriouse_game/ui/Contenu/ContenuCoursViewModel.dart';

class ContenuCoursView extends StatelessWidget {
  final Cours cours;
  const ContenuCoursView({super.key, required this.cours});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cours.pages?.length ?? 0,
      itemBuilder: (context, pageIndex) {
        var page = cours.pages![pageIndex];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: page.medias?.map((media) {
            if (media.type == "image") {
              return ContenuImageWidget(media: media);
            } else if (media.type == "video") {
              ContenuVideoWidget video = ContenuVideoWidget();
              video.fileLoader = ContenuCoursViewModel();
              video.data = media;
              return video;
            } else if (media.type == "text") {
              return ContenuTextWidget(filePath: media.url);
            } else {
              return const SizedBox(); // Cas inconnu
            }
          }).toList() ?? [],
        );
      },
    );
  }
}
