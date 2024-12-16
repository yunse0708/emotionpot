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

  // 데이터베이스에서 모든 일기 불러오기
  Future<void> loadDiaries() async {
    final diaries = await DBHelper.fetchAllDiaries();
    state = {for (var diary in diaries) diary.date: diary};
  }

  // 오늘 일기 작성 여부 확인
  bool isDiaryWritten(String date) {
    return state.containsKey(date);
  }

  // 일기 추가 및 상태 갱신
  Future<void> addDiary(Diary diary) async {
    if (!isDiaryWritten(diary.date)) {
      await DBHelper.insertDiary(diary);
      await loadDiaries(); // 일기 추가 후 새로고침
    } else {
      throw Exception("이미 작성된 일기가 있습니다.");
    }
  }
}
