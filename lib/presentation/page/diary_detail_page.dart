// diary_detail_page.dart
import 'package:flutter/material.dart';
import 'package:emotionpot/data/models/diary_model.dart';

class DiaryDetailPage extends StatelessWidget {
  final Diary diary;

  const DiaryDetailPage({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          '${diary.date}',
          style: const TextStyle(
            fontFamily: 'NanumPen',
            fontSize: 24,
            color: Colors.green,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              '오늘의 감정: ${diary.emotion}',
              style: const TextStyle(
                fontFamily: 'NanumPen',
                fontSize: 22,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                _getEmotionImage(diary.emotion),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '일기 내용',
              style: TextStyle(
                fontFamily: 'NanumPen',
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    diary.content,
                    style: const TextStyle(
                      fontFamily: 'NanumPen',
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 감정에 따라 이미지 경로를 반환
  String _getEmotionImage(String emotion) {
    const emotionImages = {
      '화남': 'assets/img/angry2.png',
      '피곤한': 'assets/img/tired.png',
      '좋은': 'assets/img/good.png',
      '평온': 'assets/img/tranquility.png',
      '불안': 'assets/img/unrest.png',
      '슬픔': 'assets/img/sorrow.png',
      '부끄러운': 'assets/img/shy.png',
      '걱정': 'assets/img/worry.png',
      '행복': 'assets/img/happy.png',
      '놀람': 'assets/img/surprise.png',
      '그냥': 'assets/img/neutral.png',
    };
    return emotionImages[emotion] ?? 'assets/img/neutral.png';
  }
}
