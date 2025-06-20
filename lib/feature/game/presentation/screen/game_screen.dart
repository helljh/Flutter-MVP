import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_type.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/count_down_widget.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_action.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_state.dart';
import 'package:mvp_game/feature/game/presentation/widget/color_pad.dart';
import 'package:mvp_game/feature/game/presentation/widget/direction_pad.dart';
import 'package:mvp_game/feature/type/presentation/controller/game_flow_view_model.dart';
import 'package:provider/provider.dart';

import '../widget/number_pad.dart';

class GameScreen extends StatelessWidget {
  final GameState state;
  final void Function(GameAction action) onAction;
  const GameScreen({super.key, required this.state, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final gameType = context.read<GameFlowViewModel>().selectedType;

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 24),
          !state.isCountDownFinished
              ? Text(
                _getInitialText(gameType!),
                style: FontStyles.largeTextRegular,
                textAlign: TextAlign.center,
              )
              : _GameInstructionWidget(type: gameType!),
          const SizedBox(height: 12),
          Opacity(
            opacity: state.isCountDownFinished ? 0 : 1,
            child: CountdownWidget(
              key: const ValueKey('start'),
              count: _getCountdownDuration(gameType),
              onFinished:
                  (value) => onAction(GameAction.onCountDownFinished(value)),
            ),
          ),
          const SizedBox(height: 24),
          _GamePadWidget(type: gameType, state: state, onAction: onAction),
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

  String _getInitialText(GameType type) => switch (type) {
    GameType.number => '5초 후에\n 숫자패드가 뒤집힙니다',
    GameType.color => '7초 후에\n 색상패드가 뒤집힙니다',
    GameType.direction => '10초 후에\n 방향패드가 뒤집힙니다',
  };

  int _getCountdownDuration(GameType type) => switch (type) {
    GameType.number => 5,
    GameType.color => 7,
    GameType.direction => 10,
  };
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

class _GameInstructionWidget extends StatelessWidget {
  final GameType type;
  const _GameInstructionWidget({required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case GameType.number:
        return const Text(
          '1부터 9까지\n 순서대로 눌러주세요',
          style: FontStyles.largeTextRegular,
          textAlign: TextAlign.center,
        );
      case GameType.color:
        return const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorBox(color: Colors.red),
                ColorBox(color: Colors.orange),
                ColorBox(color: Colors.yellow),
                ColorBox(color: Colors.green),
                ColorBox(color: Colors.blue),
                ColorBox(color: Colors.indigo),
                ColorBox(color: Colors.purple),
                ColorBox(color: Colors.brown),
                ColorBox(color: Colors.black),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '순서대로 눌러주세요',
              style: FontStyles.largeTextRegular,
              textAlign: TextAlign.center,
            ),
          ],
        );
      case GameType.direction:
        return const Text(
          '시계방향\n순서대로 눌러주세요',
          style: FontStyles.largeTextRegular,
          textAlign: TextAlign.center,
        );
    }
  }
}

class _GamePadWidget extends StatelessWidget {
  final GameType type;
  final GameState state;
  final void Function(GameAction action) onAction;

  const _GamePadWidget({
    required this.type,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      GameType.number => NumberPad(
        key: const ValueKey('number_pad'),
        state: state,
        decreaseCount: (value) => onAction(GameAction.decreaseCount(value)),
        gameSuccess: () => onAction(const GameAction.gameSuccess()),
        gameFail: () => onAction(const GameAction.gameFail()),
      ),
      GameType.color => ColorPad(
        key: const ValueKey('color_pad'),
        state: state,
        decreaseCount: (value) => onAction(GameAction.decreaseCount(value)),
        gameSuccess: () => onAction(const GameAction.gameSuccess()),
        gameFail: () => onAction(const GameAction.gameFail()),
      ),
      GameType.direction => DirectionPad(
        // 예시
        key: const ValueKey('direction_pad'),
        state: state,
        decreaseCount: (value) => onAction(GameAction.decreaseCount(value)),
        gameSuccess: () => onAction(const GameAction.gameSuccess()),
        gameFail: () => onAction(const GameAction.gameFail()),
      ),
    };
  }
}
