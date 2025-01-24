import '../DataBase/database_helper.dart';
import '../models/mediaLecon.dart';

class MediaLeconRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;


  Future<List<MediaLecon>> getAll() async {
    final db = await _dbHelper.database;
    final result = await db.query('MediaLecon');
    return result.map((map) => MediaLecon.fromMap(map)).toList();
  }
  // Créer un MediaLecon
  Future<int> create(MediaLecon mediaLecon) async {
    final db = await _dbHelper.database;
    return await db.insert('MediaLecon', mediaLecon.toMap());
  }

  // Lire tous les MediaLecon associés à une leçon
  Future<List<MediaLecon>> getByLecon(int idLecon) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'MediaLecon',
      where: 'id_lecon = ?',
      whereArgs: [idLecon],
    );

    return List.generate(maps.length, (i) {
      return MediaLecon.fromMap(maps[i]);
    });
  }

  // Lire un MediaLecon par son id
  Future<MediaLecon?> getById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'MediaLecon',
      where: 'id= ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MediaLecon.fromMap(maps.first);
    }
    return null;
  }

  // Mettre à jour un MediaLecon
  Future<int> update(MediaLecon mediaLecon) async {
    final db = await _dbHelper.database;
    return await db.update(
      'MediaLecon',
      mediaLecon.toMap(),
      where: 'id = ?',
      whereArgs: [mediaLecon.id],
    );
  }

  // Supprimer un MediaLecon
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'MediaLecon',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
