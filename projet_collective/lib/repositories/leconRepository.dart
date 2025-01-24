import '../DataBase/database_helper.dart';
import '../models/lecon.dart';

class LeconRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Créer une Lecon
  Future<int> create(Lecon lecon) async {
    final db = await _dbHelper.database;
    return await db.insert('Lecon', lecon.toMap());
  }

  // Lire toutes les Lecons
  Future<List<Lecon>> getAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Lecon');

    return List.generate(maps.length, (i) {
      return Lecon.fromMap(maps[i]);
    });
  }

  // Lire une Lecon par son ID
  Future<Lecon?> getById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Lecon',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Lecon.fromMap(maps.first);
    }
    return null;
  }

  // Mettre à jour une Lecon
  Future<int> update(Lecon lecon) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Lecon',
      lecon.toMap(),
      where: 'id = ?',
      whereArgs: [lecon.id],
    );
  }

  // Supprimer une Lecon
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Lecon',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
