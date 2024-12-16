import 'package:emotionpot/data/models/diary_model.dart';
import 'package:emotionpot/data/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class DiaryRepository {
  Future<void> insertDiary(Diary diary) async {
    final db = await DBHelper.database;
    await db.insert(
      'diaries',
      diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Diary>> fetchDiaries() async {
    final db = await DBHelper.database;
    final result = await db.query('diaries');
    return result.map((data) => Diary.fromMap(data)).toList();
  }
}
