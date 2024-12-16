import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotionpot/data/models/diary_model.dart';
import 'package:emotionpot/data/providers/diary_provider.dart';

class WritePage extends ConsumerStatefulWidget {
  final String selectedEmotion; // 선택된 감정
  final String date; // 선택된 날짜

  const WritePage(
      {super.key, required this.selectedEmotion, required this.date});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final TextEditingController _contentController = TextEditingController();

  // 저장 버튼 클릭 시 동작
  void saveDiary() {
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      showSnackBar('내용을 입력해주세요.');
      return;
    }

    final diary = Diary(
      date: widget.date,
      emotion: widget.selectedEmotion,
      content: content,
    );

    // Riverpod 상태 업데이트
    ref.read(diaryProvider.notifier).addDiary(diary);

    showSnackBar('일기가 저장되었습니다!');
    Navigator.pop(context); // 저장 후 이전 화면으로 돌아가기
  }

  // SnackBar 표시 함수
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'NanumPen'),
        ),
        behavior: SnackBarBehavior.floating,
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
                SvgPicture.asset(
                  'assets/img/calendar.svg',
                  width: 24,
                  height: 24,
                  color: Colors.black54,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.date, // 선택된 날짜를 표시
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

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}