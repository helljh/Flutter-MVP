import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_type.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/banner_ad_widget.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                '게임을 선택해 주세요',
                textAlign: TextAlign.center,
                style: FontStyles.mediumTextRegular,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseSelectBox(
                      title: "숫자",
                      subtitle: "Level 1",
                      onTap: () => onTapType(GameType.number),
                    ),
                    BaseSelectBox(
                      title: "색상",
                      subtitle: "Level 2",
                      onTap: () => onTapType(GameType.color),
                    ),
                    BaseSelectBox(
                      title: "방향",
                      subtitle: "Level 3",
                      onTap: () => onTapType(GameType.direction),
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
