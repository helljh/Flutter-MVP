// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/base_app_bar.dart';
import 'package:mvp_game/core/widget/count_down_widget.dart';

import '../widget/number_pad.dart';

class GameScreen extends StatefulWidget {
  final GameLevel level;
  final VoidCallback onTapRestart;
  final VoidCallback onTapHome;
  const GameScreen({
    super.key,
    required this.level,
    required this.onTapRestart,
    required this.onTapHome,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  bool isCountDownFinished = false;
  late List<int> questionList;
  int leftCount = 3;

  @override
  void initState() {
    super.initState();
    // 게임에 사용할 숫자 리스트 생성 및 섞기
    questionList = List.generate(16, (index) => index + 1)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '숫자',
        centerTitle: true,
        leading: GestureDetector(child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),

              !isCountDownFinished
                  ? const Text(
                    '5초 후에\n 숫자패드가 뒤집힙니다',
                    style: FontStyles.largeTextRegular,
                    textAlign: TextAlign.center,
                  )
                  : const Text(
                    '1부터 9까지\n 순서대로 눌러주세요',
                    style: FontStyles.largeTextRegular,
                    textAlign: TextAlign.center,
                  ),
              const SizedBox(height: 12),

              CountdownWidget(
                key: const ValueKey('start'),
                count: 5,
                onFinished: (value) {
                  if (value == 0) {
                    setState(() {
                      isCountDownFinished = true;
                    }); // 5초 후 모든 셀 뒤집기
                  }
                },
              ),
              const SizedBox(height: 24),
              NumberPad(
                size: 4,
                questionList: questionList,
                isCountDownFinished: isCountDownFinished,
                leftCount: leftCount,
                decreaseCount: (count) {
                  setState(() {
                    leftCount = count;
                  });
                },
                onTapRestart: widget.onTapRestart,
                onTapHome: widget.onTapHome,
              ),
              const SizedBox(height: 24),
              if (isCountDownFinished)
                RichText(
                  text: TextSpan(
                    style: FontStyles.mediumTextRegular.copyWith(
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: '남은 횟수: '),
                      TextSpan(
                        text: '$leftCount',
                        style: FontStyles.mediumTextBold.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
