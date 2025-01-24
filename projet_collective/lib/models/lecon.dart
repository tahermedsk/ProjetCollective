import 'mediaLecon.dart';

class Lecon {
   int? id;
   int idCours;
   String titre;
   String contenu;
   List<MediaLecon>? medias;

  Lecon({
    this.id,
    required this.idCours,
    required this.titre,
    required this.contenu,
  });

  // Convertir une Lecon en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_cours': idCours,
      'titre': titre,
      'contenu': contenu,
    };
  }

  // Construire une Lecon depuis un Map (SQLite)
  factory Lecon.fromMap(Map<String, dynamic> map) {
    return Lecon(
      id: map['id_lecon'],
      idCours: map['id_cours'],
      titre: map['titre'],
      contenu: map['contenu'],
    );
  }


}
