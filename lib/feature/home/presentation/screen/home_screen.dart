// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mvp_game/feature/home/presentation/widget/animated_finger.dart';
import 'package:mvp_game/core/widget/basic_button.dart';
import 'package:mvp_game/core/ui/font_styles.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onTapStartBtn;
  const HomeScreen({super.key, required this.onTapStartBtn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: FontStyles.largeTextRegular.copyWith(
                        height: 2,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(text: '오늘의 '),
                        TextSpan(
                          text: 'MVP',
                          style: FontStyles.largeTextBold.copyWith(
                            height: 2,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: '가'),
                      ],
                    ),
                  ),
                  Text(
                    '되시겠습니까?',
                    style: FontStyles.largeTextRegular.copyWith(height: 2),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const AnimatedFinger(),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: BasicButton(
                      title: const Text(
                        '게임 시작',
                        style: FontStyles.mediumTextRegular,
                      ),
                      shape: BoxShape.rectangle,
                      onTapStartBtn: onTapStartBtn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
