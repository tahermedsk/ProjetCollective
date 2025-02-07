import 'package:flutter/material.dart';
import 'package:seriouse_game/models/mediaCours.dart';
import 'package:seriouse_game/ui/Contenu/ContenuCoursViewModel.dart';

class ContenuImageWidget extends StatelessWidget {
  final MediaCours media;
  final ContenuCoursViewModel viewModel = ContenuCoursViewModel(); // Instance du ViewModel

  ContenuImageWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    String? imagePath = viewModel.imageLoader(media);

    return imagePath != null
        ? Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
            },
          )
        : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
  }
}
