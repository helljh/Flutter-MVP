import 'package:flutter/material.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/count_down_widget.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_action.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_state.dart';

import '../widget/number_pad.dart';

class GameScreen extends StatelessWidget {
  final GameState state;
  final void Function(GameAction action) onAction;
  const GameScreen({super.key, required this.state, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 24),
          !state.isCountDownFinished
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
            opacity: state.isCountDownFinished ? 0 : 1,
            child: CountdownWidget(
              key: const ValueKey('start'),
              count: 5,
              onFinished:
                  (value) => onAction(GameAction.onCountDownFinished(value)),
            ),
          ),
          const SizedBox(height: 24),
          NumberPad(
            state: state, // 새로 생성하지 않고 전달받은 state 사용
            decreaseCount:
                (int value) => onAction(GameAction.decreaseCount(value)),
            gameSuccess: () => onAction(const GameAction.gameSuccess()),
            gameFail: () => onAction(const GameAction.gameFail()),
          ),
          const SizedBox(height: 24),
          if (state.isCountDownFinished)
            RichText(
              text: TextSpan(
                style: FontStyles.mediumTextRegular.copyWith(
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(text: '남은 횟수: '),
                  TextSpan(
                    text: '${state.trialCount}',
                    style: FontStyles.mediumTextBold.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
