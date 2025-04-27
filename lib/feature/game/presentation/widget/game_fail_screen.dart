import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mvp_game/core/widget/basic_button.dart';
import '../../../../core/ui/font_styles.dart';

class GameFailScreen extends StatelessWidget {
  final VoidCallback onTapHome;
  final VoidCallback onTapRestart;
  const GameFailScreen({
    super.key,
    required this.onTapHome,
    required this.onTapRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '실패',
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
                        '...',
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
                    title: const Icon(Icons.refresh_outlined),
                    shape: BoxShape.circle,
                    onTapStartBtn: onTapRestart,
                  ),
                  const SizedBox(height: 24),
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
