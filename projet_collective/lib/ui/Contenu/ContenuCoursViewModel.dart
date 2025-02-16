import 'package:seriouse_game/models/mediaCours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seriouse_game/models/mediaCours.dart';
import 'package:video_player/video_player.dart';

class ContenuCoursViewModel {
  ContenuCoursViewModel();

  VideoPlayerController VideoLoader(MediaCours mediaModel){

      late VideoPlayerController controller;

      try {
        
        
        controller = VideoPlayerController.asset(mediaModel.url);
        
        
      } on Exception catch (e) {
        rethrow;
      }

      return controller ;

  }

  String? imageLoader(MediaCours data) {
    if (data.type == "image") {
      return data.url; // Retourne le chemin du fichier image
    }
    return null; // Retourne null si ce n'est pas une image
  }
}


