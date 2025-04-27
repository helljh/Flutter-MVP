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
  final VoidCallback onTapBack;
  const GameScreen({
    super.key,
    required this.level,
    required this.onTapRestart,
    required this.onTapHome,
    required this.onTapBack,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  bool isCountDownFinished = false;
  late List<int> questionList;
  int trialCount = 3;

  @override
  void initState() {
    super.initState();
    // 1부터 9까지의 숫자만 생성하고 섞기
    List<int> numbers = List.generate(9, (index) => index + 1)..shuffle();

    // 전체 격자판 크기만큼의 리스트 생성 (비어있는 칸은 -1로 표시)
    questionList = List.generate(widget.level.totalCount, (index) {
      if (index < numbers.length) {
        return numbers[index]; // 1-9 중 하나의 숫자 배치
      } else {
        return -1; // 빈 칸은 -1로 표시
      }
    });

    // 숫자들의 위치를 다시 한번 섞기
    questionList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '숫자',
        centerTitle: true,
        leading: GestureDetector(
          onTap: widget.onTapBack,
          child: const Icon(Icons.arrow_back_ios),
        ),
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

              Opacity(
                opacity: isCountDownFinished ? 0 : 1,
                child: CountdownWidget(
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
              ),
              const SizedBox(height: 24),
              NumberPad(
                size: widget.level.size,
                questionList: questionList,
                isCountDownFinished: isCountDownFinished,
                leftCount: trialCount,
                decreaseCount: (count) {
                  setState(() {
                    trialCount = count;
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
                        text: '$trialCount',
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
