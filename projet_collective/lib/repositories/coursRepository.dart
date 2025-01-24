import 'package:seriouse_game/models/cours.dart';
import 'package:seriouse_game/DataBase/database_helper.dart';

class CoursRepository{
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // --- CRUD Methods ---
   Future<int> create(Cours cours) async {
    final db = await _dbHelper.database;
    return await db.insert('cours', cours.toMap());
  }

  Future<Cours?> getById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Cours',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cours.fromMap(maps.first);
    }
    return null;
  }

   Future<List<Cours>> getAll() async {
    final db = await _dbHelper.database;
    final result = await db.query('Cours');
    return result.map((map) => Cours.fromMap(map)).toList();
  }

   Future<int> update(Cours cours) async {
    final db = await _dbHelper.database;
    return await db.update(
      'cours',
      cours.toMap(),
      where: 'id = ?',
      whereArgs: [cours.id],
    );
  }

   Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'cours',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}