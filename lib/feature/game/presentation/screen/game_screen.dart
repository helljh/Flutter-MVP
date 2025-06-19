import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_type.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/count_down_widget.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_action.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_state.dart';
import 'package:mvp_game/feature/game/presentation/widget/color_pad.dart';
import 'package:mvp_game/feature/type/presentation/controller/game_flow_view_model.dart';
import 'package:provider/provider.dart';

import '../widget/number_pad.dart';

class GameScreen extends StatelessWidget {
  final GameState state;
  final void Function(GameAction action) onAction;
  const GameScreen({super.key, required this.state, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final isNumberType =
        context.read<GameFlowViewModel>().selectedType == GameType.number;

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 24),
          !state.isCountDownFinished
              ? Text(
                isNumberType ? '5초 후에\n 숫자패드가 뒤집힙니다' : '5초 후에\n 색상패드가 뒤집힙니다',
                style: FontStyles.largeTextRegular,
                textAlign: TextAlign.center,
              )
              : isNumberType
              ? const Text(
                '1부터 9까지\n 순서대로 눌러주세요',
                style: FontStyles.largeTextRegular,
                textAlign: TextAlign.center,
              )
              : const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorBox(color: Colors.red), // 빨강
                      ColorBox(color: Colors.orange), // 주황
                      ColorBox(color: Colors.yellow), // 노랑
                      ColorBox(color: Colors.green), // 초록
                      ColorBox(color: Colors.blue), // 하늘
                      ColorBox(color: Colors.indigo), // 파랑
                      ColorBox(color: Colors.purple), // 보라
                      ColorBox(color: Colors.brown), // 갈색
                      ColorBox(color: Colors.black), // 검정
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '순서대로 눌러주세요',
                    style: FontStyles.largeTextRegular,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          const SizedBox(height: 12),
          Opacity(
            opacity: state.isCountDownFinished ? 0 : 1,
            child: CountdownWidget(
              key: const ValueKey('start'),
              count: isNumberType ? 5 : 7,
              onFinished:
                  (value) => onAction(GameAction.onCountDownFinished(value)),
            ),
          ),
          const SizedBox(height: 24),
          isNumberType
              ? NumberPad(
                key: const ValueKey('number_pad'),
                state: state, // 새로 생성하지 않고 전달받은 state 사용
                decreaseCount:
                    (int value) => onAction(GameAction.decreaseCount(value)),
                gameSuccess: () => onAction(const GameAction.gameSuccess()),
                gameFail: () => onAction(const GameAction.gameFail()),
              )
              : ColorPad(
                key: const ValueKey('color_pad'),
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

class ColorBox extends StatelessWidget {
  final Color color;
  const ColorBox({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );
  }
}
