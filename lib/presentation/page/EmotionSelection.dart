import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emotionpot/presentation/page/write_page.dart';

class EmotionSelectionPage extends StatefulWidget {
  const EmotionSelectionPage({super.key});

  @override
  State<EmotionSelectionPage> createState() => _EmotionSelectionPageState();
}

class _EmotionSelectionPageState extends State<EmotionSelectionPage> {
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

  // 현재 날짜 반환
  String getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';
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
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 20.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/img/calendar.svg',
                  width: 24,
                  height: 24,
                  color: Colors.black54,
                ),
                const SizedBox(width: 5),
                Text(
                  getCurrentDate(),
                  style: const TextStyle(
                    fontFamily: 'NanumPen',
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
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

                return EmotionTile(
                  label: emotion['label'] as String,
                  imagePath: emotion['image'] as String,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedEmotion = emotion['label'];
                    });
                  },
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
                      selectedEmotion == null ? null : const Color(0xFF059669),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: selectedEmotion == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WritePage(
                              selectedEmotion: selectedEmotion!,
                              date: getCurrentDate(), // 날짜 전달
                            ),
                          ),
                        );
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

class EmotionTile extends StatelessWidget {
  final String label;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const EmotionTile({
    super.key,
    required this.label,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Opacity(
            opacity: isSelected ? 1.0 : 0.5,
            child: Container(
              height: 73,
              width: 87,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'NanumPen',
              fontSize: 22,
              color: isSelected ? Colors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
