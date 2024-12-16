import 'package:flutter/material.dart';
import 'package:emotionpot/presentation/page/EmotionSelection.dart'; // EmotionSelectionPage 파일을 임포트

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 상단 여백과 새싹 아이콘
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/img/angry.png'),
                ),
              ),
            ),
            const SizedBox(height: 40), // 여백 추가 (이미지 기준 조정)

            // 메인 새싹 이미지 (화난 상태)
            SizedBox(
              height: 120,
              child: Image.asset('assets/img/angry.png'),
            ),
            const SizedBox(height: 30), // 간격 수정

            // 어제의 기분 박스
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F9E6), // 연한 녹색
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  '어제의 기분은 [화남]이었습니다.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30), // 여백 추가

            // 오늘의 문장
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF00C278), // 진한 녹색
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘의 문장',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8), // 간격 수정
                  Text(
                    '오늘 하루도 수고했어\n넌 정말 최고야아아아아!!!!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8), // 간격 수정
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '- 송윤서',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30), // 여백 조정

            // 하단 버튼 2개
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C278),
                        padding: const EdgeInsets.symmetric(
                            vertical: 18), // 버튼 높이 조정
                      ),
                      onPressed: () {
                        // 오늘의 하루 기록하기 버튼 클릭 시 EmotionSelectionPage로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmotionSelectionPage(),
                          ),
                        );
                      },
                      child: const Text(
                        '오늘의 하루 기록하기',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C278),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      onPressed: () {
                        // 지난 기록 보러가기 버튼 클릭 시 다른 동작을 추가할 수 있습니다.
                      },
                      child: const Text(
                        '지난 기록 보러가기',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // 하단 여백 추가
          ],
        ),
      ),
    );
  }
}
