// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mvp_game/presentation/home/presentation/widget/basic_button.dart';

import '../../../../core/ui/font_styles.dart';

class GameSuccessScreen extends StatelessWidget {
  final VoidCallback onTapHome;

  const GameSuccessScreen({super.key, required this.onTapHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '게임 성공',
                  style: FontStyles.headerTextBold.copyWith(
                    color: Colors.black,
                  ),
                ),
                DefaultTextStyle(
                  style: FontStyles.headerTextBold.copyWith(
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '!!',
                        speed: const Duration(milliseconds: 300),
                        cursor: '',
                      ),
                    ],
                    repeatForever: true,
                  ),
                ),
              ],
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BasicButton(
                    title: const Icon(Icons.home_outlined),
                    shape: BoxShape.circle,
                    onTapStartBtn: onTapHome,
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
