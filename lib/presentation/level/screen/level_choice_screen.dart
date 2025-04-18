import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/base_app_bar.dart';

import '../../../core/widget/base_select_box.dart';

class LevelChoiceScreen extends StatelessWidget {
  final VoidCallback onTapBack;
  final Function(GameLevel level) onTapLevel;

  const LevelChoiceScreen({
    super.key,
    required this.onTapBack,
    required this.onTapLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading: GestureDetector(
          onTap: onTapBack,
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 24,
            right: 0,
            left: 0,
            child: Center(
              child: Text('난이도를 선택해 주세요', style: FontStyles.mediumTextRegular),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseSelectBox(
                  title: "3 X 3",
                  onTap: () => onTapLevel(GameLevel.three),
                ),
                const SizedBox(height: 24),
                BaseSelectBox(
                  title: "4 X 4",
                  onTap: () => onTapLevel(GameLevel.four),
                ),
                const SizedBox(height: 24),
                BaseSelectBox(
                  title: "5 X 5",
                  onTap: () => onTapLevel(GameLevel.five),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
