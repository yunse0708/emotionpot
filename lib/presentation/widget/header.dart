import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emotionpot/app/config/app_color.dart';
import 'package:emotionpot/app/config/app_text_styles.dart';
import 'package:emotionpot/presentation/page/home_page.dart'; // HomePage를 import

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 50,
          padding: const EdgeInsets.only(
            top: 11,
            left: 16,
            right: 16, // 오른쪽 여백을 줄여 균형 맞춤
            bottom: 11,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: AppColor.gray200),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 정렬
            children: [
              // Close 버튼 (SvgPicture로 표시)
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false, // 기존 스택 모두 제거
                  );
                },
                child: SvgPicture.asset(
                  'assets/img/Close.svg', // Close SVG 경로
                  width: 28,
                  height: 28,
                ),
              ),
              // 회원가입 텍스트
              Text(
                '회원가입',
                style: AppTextStyles.page.copyWith(
                  color: AppColor.gray950,
                ),
              ),
              SizedBox(width: 28), // Close 버튼과 대칭 맞추기
            ],
          ),
        ),
      ],
    );
  }
}
