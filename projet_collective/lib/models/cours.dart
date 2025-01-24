import 'package:seriouse_game/models/lecon.dart';


class Cours {
   int? id; // `id` est nullable pour les nouvelles entrées
   String titre;
   String description;
   List<Lecon>? lecons;
  Cours({
    this.id,
    required this.titre,
    required this.description,
  });

  // Convertir un objet en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
    };
  }

  // Convertir une ligne SQLite en objet Cours
  static Cours fromMap(Map<String, dynamic> map) {
    return Cours(
      id: map['id'],
      titre: map['titre'],
      description: map['description'],
    );
  }

}
