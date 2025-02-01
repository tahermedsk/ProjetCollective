import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  // Méthode pour obtenir la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  // Initialisation de la base de données
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //resetDatabase();
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        // Appeler _createDB pour recréer les tables si nécessaire
        await _createDB(db, 1);
      },
    );

  }

  // Crée les tables dans la base de données
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS cours (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        description TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS lecon (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        contenu TEXT NOT NULL,
        id_cours INTEGER,
        FOREIGN KEY (id_cours) REFERENCES cours (id)
      );
    ''');


    await db.execute('''
    CREATE TABLE IF NOT EXISTS MiniJeu (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_lecon INTEGER NOT NULL,
    nom TEXT NOT NULL,
    description TEXT,
    progression INTEGER NOT NULL,
    FOREIGN KEY (id_lecon) REFERENCES lecon (id)
  );
''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS MotsCroises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_minijeu INTEGER NOT NULL,
        taille_grille TEXT NOT NULL,
        description TEXT,
        FOREIGN KEY (id_minijeu) REFERENCES MiniJeu (id) ON DELETE CASCADE

      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Mot (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_motscroises INTEGER NOT NULL,
        mot TEXT NOT NULL,
        indice TEXT NOT NULL,
        direction TEXT NOT NULL,
        position_depart_x INTEGER NOT NULL,
        position_depart_y INTEGER NOT NULL,
        FOREIGN KEY (id_motscroises) REFERENCES MotsCroises (id) ON DELETE CASCADE
      );
    ''');


    await db.execute('''
  CREATE TABLE IF NOT EXISTS MediaLecon (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_lecon INTEGER NOT NULL,
    url TEXT NOT NULL,
    type TEXT NOT NULL,
    caption TEXT,
    FOREIGN KEY (id_lecon) REFERENCES lecon (id) ON DELETE CASCADE
  );
''');

  }

  // Supprime la base de données et recrée les tables
  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    // Supprime la base de données existante
    await deleteDatabase(path);

    // Rouvre la base de données pour recréer les tables
    _database = await _initDB('app.db');
  }

  // Méthode pour fermer la base de données
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
