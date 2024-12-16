import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotionpot/data/models/diary_model.dart';
import 'package:emotionpot/data/utils/db_helper.dart';

final diaryProvider =
    StateNotifierProvider<DiaryNotifier, Map<String, Diary>>((ref) {
  return DiaryNotifier();
});

class DiaryNotifier extends StateNotifier<Map<String, Diary>> {
  DiaryNotifier() : super({}) {
    loadDiaries();
  }

  Future<void> loadDiaries() async {
    final diaries = await DBHelper.fetchAllDiaries();
    state = {for (var diary in diaries) diary.date: diary};
  }

  Future<void> addDiary(Diary diary) async {
    await DBHelper.insertDiary(diary);
    loadDiaries();
  }
}
