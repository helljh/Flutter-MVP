// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mvp_game/app/enum/game_level.dart';

class GameScreen extends StatelessWidget {
  final GameLevel level;
  const GameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(level.name.toString())));
  }
}
