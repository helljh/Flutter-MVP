import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/banner_ad_widget.dart';
import 'package:mvp_game/core/widget/base_app_bar.dart';

import '../../../../core/widget/base_select_box.dart';

class GameLevelScreen extends StatelessWidget {
  final VoidCallback onTapBack;
  final Function(GameLevel level) onTapLevel;

  const GameLevelScreen({
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                '난이도를 선택해 주세요',
                textAlign: TextAlign.center,
                style: FontStyles.mediumTextRegular,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseSelectBox(
                      title: "3 X 3",
                      onTap: () => onTapLevel(GameLevel.three),
                    ),
                    BaseSelectBox(
                      title: "4 X 4",
                      onTap: () => onTapLevel(GameLevel.four),
                    ),

                    BaseSelectBox(
                      title: "5 X 5",
                      onTap: () => onTapLevel(GameLevel.five),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const BannerAdWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
