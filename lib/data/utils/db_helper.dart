import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:emotionpot/data/models/diary_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    // 데이터베이스 초기화
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'diary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE diaries (
            date TEXT PRIMARY KEY,
            emotion TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  // 일기 추가
  static Future<void> insertDiary(Diary diary) async {
    final db = await database;
    await db.insert('diaries', diary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // 모든 일기 조회
  static Future<List<Diary>> fetchAllDiaries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diaries');
    return List.generate(maps.length, (i) => Diary.fromMap(maps[i]));
  }
}
