import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/routing/route_path.dart';
import 'package:mvp_game/feature/level/presentation/screen/game_level_screen.dart';
import 'package:mvp_game/feature/type/presentation/controller/game_flow_view_model.dart';
import 'package:provider/provider.dart';

class GameLevelScreenRoot extends StatelessWidget {
  const GameLevelScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return GameLevelScreen(
      onTapBack: () => context.go(RoutePath.gameType),
      onTapLevel: (level) {
        context.read<GameFlowViewModel>().selectLevel(level);
        context.go(RoutePath.countDown);
      },
    );
  }
}
