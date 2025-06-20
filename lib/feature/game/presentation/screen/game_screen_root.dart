import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/routing/route_path.dart';
import 'package:mvp_game/core/widget/base_app_bar.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_action.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_view_model.dart';
import 'package:mvp_game/feature/game/presentation/screen/game_screen.dart';
import 'package:mvp_game/feature/type/presentation/controller/game_flow_view_model.dart';
import 'package:provider/provider.dart';

class GameScreenRoot extends StatefulWidget {
  final GameViewModel viewModel;
  const GameScreenRoot({super.key, required this.viewModel});

  @override
  State<GameScreenRoot> createState() => _GameScreenRootState();
}

class _GameScreenRootState extends State<GameScreenRoot> {
  @override
  void initState() {
    super.initState();
    final level = context.read<GameFlowViewModel>().selectedLevel!;
    final gameType = context.read<GameFlowViewModel>().selectedType!;

    widget.viewModel.setGameData(level, gameType);
  }

  @override
  Widget build(BuildContext context) {
    final gameType = context.read<GameFlowViewModel>().selectedType!;
    return Scaffold(
      appBar: BaseAppBar(
        title: gameType.label,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.go(RoutePath.levelChoice),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          final gameState = widget.viewModel.state;
          if (gameState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: GameScreen(
              state: gameState,
              onAction: (action) {
                switch (action) {
                  case OnCountDownFinished():
                    if (action.value == 0) {
                      widget.viewModel.changeCountDownFinished();
                      print(widget.viewModel.state.isCountDownFinished);
                    } // 5초 후 모든 셀 뒤집기
                  case DecreaseCount():
                    widget.viewModel.decreaseTrialCount(action.count);
                  case GameSuccess():
                    context.go(RoutePath.gameSuccess);
                  case GameFail():
                    context.go(RoutePath.gameFail);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
