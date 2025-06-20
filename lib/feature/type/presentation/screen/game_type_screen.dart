import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_type.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/base_app_bar.dart';
import 'package:mvp_game/core/widget/base_select_box.dart';

class GameTypeScreen extends StatelessWidget {
  final VoidCallback onTapBack;
  final Function(GameType type) onTapType;

  const GameTypeScreen({
    super.key,
    required this.onTapBack,
    required this.onTapType,
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
              child: Text('게임종류를 선택해 주세요', style: FontStyles.mediumTextRegular),
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
                  title: "숫자",
                  subtitle: "Level 1",
                  onTap: () => onTapType(GameType.number),
                ),
                const SizedBox(height: 48),
                BaseSelectBox(
                  title: "색상",
                  subtitle: "Level 2",
                  onTap: () => onTapType(GameType.color),
                ),
                const SizedBox(height: 48),
                BaseSelectBox(
                  title: "방향",
                  subtitle: "Level 3",
                  onTap: () => onTapType(GameType.direction),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
