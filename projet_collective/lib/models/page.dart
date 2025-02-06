class Page {
  int? id;
  int ordre;
  int idCours;
  String? description ;

  Page({
    this.id,
    required this.ordre,
    required this.idCours,
     this.description ,
  });

  // Convertir un objet Page en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ordre': ordre,
      'id_cours': idCours,
      'description':description,
    };
  }

  // Créer un objet Page à partir d'une Map SQLite
  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
      id: map['id'],
      ordre: map['ordre'],
      idCours: map['id_cours'],
      description: map['description']
    );
  }
}
