import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/enum/game_type.dart';
import 'package:mvp_game/core/routing/route_path.dart';
import 'package:mvp_game/feature/type/presentation/controller/game_flow_view_model.dart';
import 'package:mvp_game/feature/type/presentation/screen/game_type_screen.dart';
import 'package:provider/provider.dart';

class GameTypeScreenRoot extends StatelessWidget {
  const GameTypeScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return GameTypeScreen(
      onTapBack: () => context.pop(),
      onTapType: (GameType type) {
        context.read<GameFlowViewModel>().selectGameType(type);
        context.push(RoutePath.levelChoice);
      },
    );
  }
}
