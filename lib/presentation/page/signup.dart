import 'package:flutter/material.dart';
import 'package:emotionpot/app/config/app_color.dart';
import 'package:emotionpot/presentation/widget/header.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이름 필드
                    _buildInputField(
                      label: '이름',
                      hintText: '이름',
                      helperText: '   4~12자/영문 소문자(숫자 조합 가능)',
                    ),
                    SizedBox(height: 16),

                    // 아이디 필드
                    _buildInputField(
                      label: '아이디',
                      hintText: '아이디',
                    ),
                    SizedBox(height: 16),

                    // 비밀번호 필드
                    _buildInputField(
                      label: '비밀번호',
                      hintText: '비밀번호',
                    ),
                    SizedBox(height: 8),
                    _buildInputField(
                      label: '',
                      hintText: '비밀번호 재입력',
                      helperText: '   6~20자/영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상 조합',
                    ),
                    SizedBox(height: 16),

                    // 이메일 필드
                    _buildEmailField(),
                    SizedBox(height: 16),

                    Text(
                      '   더 안전하게 계정을 보호하려면 가입 후 [내정보]에서 이메일 인증을\n   진행해주세요.',
                      style: TextStyle(
                        color: AppColor.gray400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 90),

                    // 가입하기 버튼
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // 가입하기 이벤트 처리
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.green600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            '가입하기',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    String? helperText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.gray600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.red,
                ),
              ),
            ],
          ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColor.gray400,
              fontSize: 16,
            ),
            fillColor: AppColor.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.gray300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.gray300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.gray300),
            ),
          ),
          style: TextStyle(
            color: AppColor.gray900,
            fontSize: 16,
          ),
        ),
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              helperText,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.gray400,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '이메일',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.gray600,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.red,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '이메일',
                  hintStyle: TextStyle(color: AppColor.gray400),
                  fillColor: AppColor.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.gray300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.gray300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.gray300),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('@'),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '선택',
                  hintStyle: TextStyle(color: AppColor.gray400),
                  fillColor: AppColor.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.gray300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.gray300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.gray300),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
