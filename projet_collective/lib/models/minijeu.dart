import 'package:seriouse_game/models/motsCroises.dart';

class MiniJeu {
   int? id;
   int idLecon;
   String nom;
   String? description;
   int progression;
   List<MotsCroises>? motsCroises; // Liste des mots croisés associés

  MiniJeu({
    this.id,
    required this.idLecon,
    required this.nom,
    this.description,
    required this.progression,
  });

  // Conversion en Map pour SQLite (sans les mots croisés)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_lecon': idLecon,
      'nom': nom,
      'description': description,
      'progression': progression,
    };
  }

  // Conversion d'une Map SQLite en objet (sans les mots croisés)
  factory MiniJeu.fromMap(Map<String, dynamic> map) {
    return MiniJeu(
      id: map['id'],
      idLecon: map['id_lecon'],
      nom: map['nom'],
      description: map['description'],
      progression: map['progression'],
    );
  }


}
