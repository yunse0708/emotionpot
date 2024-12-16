import 'package:emotionpot/presentation/page/home.dart';
import 'package:flutter/material.dart';
import 'package:emotionpot/app/config/app_color.dart';
import 'package:emotionpot/app/config/app_text_styles.dart';
import 'package:emotionpot/presentation/page/signup.dart'; // Signup 페이지 import

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 100), // 상단 여백
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 메인 타이틀
                  Text(
                    '감정팟’',
                    style: AppTextStyles.logo.copyWith(
                      color: AppColor.green600,
                      height: 1,
                    ),
                  ),
                  Text(
                    '당신의 감정을 기록해보세요',
                    style: AppTextStyles.content.copyWith(
                      color: AppColor.gray700,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 하단 버튼 및 텍스트
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 계정 만들기 버튼
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Signup 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.green600,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '계정만들기',
                        style: AppTextStyles.Regular24.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                // 이미 계정이 있나요? 로그인
                TextButton(
                  onPressed: () {
                    // 로그인 이벤트
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '이미 계정이 있나요?  ',
                      style: AppTextStyles.Regular16.copyWith(
                        color: AppColor.gray500,
                      ),
                      children: [
                        TextSpan(
                          text: '로그인',
                          style: AppTextStyles.Regular16.copyWith(
                            color: AppColor.green600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 47), // 하단 여백
              ],
            ),
          ),
        ],
      ),
    );
  }
}
