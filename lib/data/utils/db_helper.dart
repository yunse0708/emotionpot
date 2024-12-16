import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/diary_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'diary.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE diaries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT UNIQUE,
            emotion TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  static Future<List<Diary>> fetchAllDiaries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diaries');
    return List.generate(maps.length, (i) => Diary.fromMap(maps[i]));
  }

  static Future<void> insertDiary(Diary diary) async {
    final db = await database;
    await db.insert('diaries', diary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
