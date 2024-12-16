import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emotionpot/presentation/page/EmotionSelection.dart';
import 'calendar_page.dart'; // 캘린더 페이지 임포트

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _yesterdayEmotion; // 어제의 감정
  int _flowerStage = 1; // 꽃의 성장 단계 (1 ~ 4)

  // 긍정적인 감정 목록
  final List<String> positiveEmotions = ['좋은', '평온', '행복'];

  // 데이터 불러오기
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _yesterdayEmotion = prefs.getString('lastEmotion') ?? '화남'; // 기본값
      _flowerStage = prefs.getInt('flowerStage') ?? 1; // 꽃의 초기 상태
    });
  }

  // 감정 저장 및 꽃 성장
  Future<void> _saveEmotion(String emotion) async {
    final prefs = await SharedPreferences.getInstance();
    int newFlowerStage = _flowerStage;

    // 긍정적인 감정일 경우 꽃이 성장
    if (positiveEmotions.contains(emotion)) {
      newFlowerStage = (_flowerStage < 4) ? _flowerStage + 1 : 4;
    }

    await prefs.setString('lastEmotion', emotion);
    await prefs.setInt('flowerStage', newFlowerStage);

    setState(() {
      _yesterdayEmotion = emotion;
      _flowerStage = newFlowerStage;
    });

    // 일기를 작성한 날짜 저장
    String currentDate = _getCurrentDate();
    await prefs.setString('diaryDate', currentDate);
  }

  // 오늘 날짜 반환
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  // 오늘 일기를 이미 작성했는지 확인
  Future<bool> _hasDiaryBeenWrittenToday() async {
    final prefs = await SharedPreferences.getInstance();
    String currentDate = _getCurrentDate();
    String? diaryDate = prefs.getString('diaryDate');
    return diaryDate == currentDate; // 오늘 날짜에 일기를 작성했으면 true 반환
  }

  String getFlowerImage() {
    return 'assets/img/flower$_flowerStage.png';
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // 데이터 불러오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 상단 아이콘
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
            const SizedBox(height: 120),

            // 메인 꽃 이미지 (현재 상태)
            SizedBox(
              height: 120,
              child: Image.asset(getFlowerImage()), // 꽃 이미지
            ),
            const SizedBox(height: 150),

            // 오늘의 문장
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '오늘 하루도 수고했어\n넌 정말 최고야아아아아!!!!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
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
            const SizedBox(height: 12),

            // 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        bool hasDiaryWritten =
                            await _hasDiaryBeenWrittenToday();
                        if (hasDiaryWritten) {
                          // 이미 오늘 일기를 작성했다면 알림을 표시
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('오늘은 이미 일기를 작성했습니다.')),
                          );
                        } else {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmotionSelectionPage(),
                            ),
                          );

                          if (result != null && result is String) {
                            _saveEmotion(result); // 감정을 저장하고 꽃 상태를 업데이트
                          }
                        }
                      },
                      child: const Text(
                        '오늘의 하루 기록하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'NanumPen', // 나눔펜 폰트 적용
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CalendarPage(), // 캘린더 페이지로 이동
                          ),
                        );
                      },
                      child: const Text(
                        '지난 기록 보러가기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'NanumPen', // 나눔펜 폰트 적용
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
