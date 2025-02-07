import 'package:seriouse_game/models/mediaCours.dart';
import 'package:flutter/material.dart';

class ContenuCoursViewModel {
  
  String? imageLoader(MediaCours data) {
    if (data.type == "image") {
      return data.url; // Retourne le chemin du fichier image
    }
    return null; // Retourne null si ce n'est pas une image
  }
}
