import 'package:emotionpot/presentation/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotionpot/data/models/diary_model.dart';
import 'package:emotionpot/data/providers/diary_provider.dart';

class WritePage extends ConsumerStatefulWidget {
  final String selectedEmotion; // 선택된 감정
  final String date; // 선택된 날짜

  const WritePage({
    super.key,
    required this.selectedEmotion,
    required this.date,
  });

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final TextEditingController _contentController = TextEditingController();

  // 일기 저장 함수
  Future<void> saveDiary() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('내용을 입력해주세요.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Diary 모델 생성
    final newDiary = Diary(
      date: widget.date,
      emotion: widget.selectedEmotion,
      content: content,
    );

    // diaryProvider를 통해 일기 저장
    await ref.read(diaryProvider.notifier).addDiary(newDiary);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('일기가 저장되었습니다!'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // 홈 화면으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              '당신의 하루를 기록해보세요!',
              style: TextStyle(
                fontFamily: 'NanumPen',
                fontSize: 28,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  widget.date, // 날짜 표시
                  style: const TextStyle(
                    fontFamily: 'NanumPen',
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '오늘의 감정: ${widget.selectedEmotion}',
              style: const TextStyle(
                fontFamily: 'NanumPen',
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FDFE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  style: const TextStyle(
                    fontFamily: 'NanumPen',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '당신의 하루를 입력해주세요.',
                    hintStyle: TextStyle(
                      fontFamily: 'NanumPen',
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: saveDiary,
                child: const Text(
                  '저장하기',
                  style: TextStyle(
                    fontFamily: 'NanumPen',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
