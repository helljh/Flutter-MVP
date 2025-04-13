// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mvp_game/presentation/home/widget/animated_finger.dart';
import 'package:mvp_game/presentation/home/widget/game_start_button.dart';
import 'package:mvp_game/app/ui/font_styles.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onTapStartBtn;
  const HomeScreen({super.key, required this.onTapStartBtn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('MVP', style: FontStyles.headerTextRegular),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
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
            const Spacer(),
            const Center(
              child: Text(
                '아래 버튼을 눌러\n 게임을 시작하세요',
                style: FontStyles.mediumTextRegular,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: const AnimatedFinger(),
            ),
            const SizedBox(height: 10),
            Center(child: GameStartButton(onTapStartBtn: onTapStartBtn)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
