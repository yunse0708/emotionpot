import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'write_page.dart';

class EmotionSelectionPage extends ConsumerStatefulWidget {
  const EmotionSelectionPage({super.key});

  @override
  ConsumerState<EmotionSelectionPage> createState() =>
      _EmotionSelectionPageState();
}

class _EmotionSelectionPageState extends ConsumerState<EmotionSelectionPage> {
  final emotions = [
    {'label': '화남', 'image': 'assets/img/angry2.png'},
    {'label': '피곤한', 'image': 'assets/img/tired.png'},
    {'label': '좋은', 'image': 'assets/img/good.png'},
    {'label': '평온', 'image': 'assets/img/tranquility.png'},
    {'label': '불안', 'image': 'assets/img/unrest.png'},
    {'label': '슬픔', 'image': 'assets/img/sorrow.png'},
    {'label': '부끄러운', 'image': 'assets/img/shy.png'},
    {'label': '걱정', 'image': 'assets/img/worry.png'},
    {'label': '행복', 'image': 'assets/img/happy.png'},
    {'label': '놀람', 'image': 'assets/img/surprise.png'},
    {'label': '그냥', 'image': 'assets/img/neutral.png'},
  ];

  String? selectedEmotion;
  int _flowerStage = 1; // 꽃 상태를 위한 변수 (초기값은 1)

  // 긍정적인 감정 목록
  final List<String> positiveEmotions = [
    '행복',
    '좋은',
    '평온',
    '그냥',
  ];

  bool _hasWrittenToday = false; // 오늘 일기를 작성했는지 여부

  // 꽃 상태를 업데이트하는 함수
  Future<void> _updateFlowerState(String emotion) async {
    final prefs = await SharedPreferences.getInstance();
    int currentFlowerStage = prefs.getInt('flowerStage') ?? 1;

    // 긍정적인 감정을 선택했을 때 꽃 상태가 증가하도록 처리
    if (positiveEmotions.contains(emotion)) {
      currentFlowerStage =
          currentFlowerStage < 4 ? currentFlowerStage + 1 : 4; // 꽃이 성장하도록
    }

    // SharedPreferences에 새로운 꽃 상태 저장
    await prefs.setInt('flowerStage', currentFlowerStage);

    // 상태를 화면에 반영
    setState(() {
      _flowerStage = currentFlowerStage;
    });
  }

  // 현재 날짜를 반환하는 함수
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _loadFlowerStage();
    _checkIfWrittenToday();
  }

  // SharedPreferences에서 꽃 상태를 불러오는 함수
  Future<void> _loadFlowerStage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _flowerStage = prefs.getInt('flowerStage') ?? 1; // 기본값은 1
    });
  }

  // 오늘 일기를 작성했는지 여부를 확인하는 함수
  Future<void> _checkIfWrittenToday() async {
    final prefs = await SharedPreferences.getInstance();
    String today = _getCurrentDate();
    String? lastWrittenDate = prefs.getString('lastWrittenDate');

    if (lastWrittenDate == today) {
      setState(() {
        _hasWrittenToday = true;
      });
    }
  }

  // 일기 작성 후 상태 업데이트
  Future<void> _markTodayAsWritten() async {
    final prefs = await SharedPreferences.getInstance();
    String today = _getCurrentDate();
    await prefs.setString('lastWrittenDate', today);

    setState(() {
      _hasWrittenToday = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          _getCurrentDate(), // 날짜를 AppBar에 표시
          style: const TextStyle(
            fontFamily: 'NanumPen',
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              '오늘 당신의 감정은 어땠나요?',
              style: TextStyle(
                fontFamily: 'NanumPen',
                fontSize: 28,
                color: Colors.green,
              ),
            ),
          ),
          // 날짜를 '오늘 당신의 감정은 어땠나요?' 아래에 추가
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0),
            child: Text(
              _getCurrentDate(),
              style: const TextStyle(
                fontFamily: 'NanumPen',
                fontSize: 22,
                color: Colors.black87,
              ),
            ),
          ),
          // 감정 선택 UI
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: emotions.length,
              itemBuilder: (context, index) {
                final emotion = emotions[index];
                final isSelected = selectedEmotion == emotion['label'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEmotion = emotion['label'];
                    });
                    // 감정을 선택하면 꽃 상태 업데이트
                    _updateFlowerState(emotion['label'] as String);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 73,
                        width: 87,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected ? Colors.green : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          emotion['image'] as String,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        emotion['label'] as String,
                        style: TextStyle(
                          fontFamily: 'NanumPen',
                          fontSize: 22,
                          color: isSelected ? Colors.green : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 42.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _hasWrittenToday ? Colors.grey : const Color(0xFF059669),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _hasWrittenToday
                    ? () {
                        // 오늘 이미 일기를 작성했다는 알림
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('오늘 이미 일기를 작성하였습니다.'),
                          ),
                        );
                      }
                    : () async {
                        // 일기 작성 페이지로 이동
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WritePage(
                              selectedEmotion: selectedEmotion!,
                              date: _getCurrentDate(),
                            ),
                          ),
                        );
                        // 일기 작성 후 상태 업데이트
                        _markTodayAsWritten();
                      },
                child: const Text(
                  '다음',
                  style: TextStyle(
                    fontFamily: 'NanumPen',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
