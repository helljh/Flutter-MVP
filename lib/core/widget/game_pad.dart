import 'package:flutter/material.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_state.dart';

abstract class GamePad extends StatefulWidget {
  final GameState state;
  final Function(int count) decreaseCount;
  final VoidCallback gameSuccess;
  final VoidCallback gameFail;

  const GamePad({
    super.key,
    required this.state,
    required this.decreaseCount,
    required this.gameSuccess,
    required this.gameFail,
  });

  @override
  State<GamePad> createState() => _GamePadState();
}

class _GamePadState extends State<GamePad> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
