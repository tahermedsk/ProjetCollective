class MediaLecon {
   int id;
   int idLecon;
   String url;
   String type;
   String? caption;

  MediaLecon({
    required this.id,
    required this.idLecon,
    required this.url,
    required this.type,
    this.caption,
  });

  // Conversion en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_lecon': idLecon,
      'url': url,
      'type': type,
      'caption': caption,
    };
  }

  // Conversion d'une Map SQLite en objet
  factory MediaLecon.fromMap(Map<String, dynamic> map) {
    return MediaLecon(
      id: map['id'],
      idLecon: map['id_media'],
      url: map['url'],
      type: map['type'],
      caption: map['caption'],
    );
  }
}
