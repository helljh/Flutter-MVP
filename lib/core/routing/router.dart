import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/routing/route_path.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_view_model.dart';
import 'package:mvp_game/feature/game/presentation/screen/game_screen_root.dart';
import 'package:mvp_game/feature/game/presentation/widget/count_down_screen.dart';
import 'package:mvp_game/feature/level/presentation/screen/game_level_screen_root.dart';
import 'package:mvp_game/feature/splash/splash_screen.dart';
import 'package:mvp_game/feature/success/game_success_screen.dart';
import 'package:mvp_game/feature/presentation/widget/game_fail_screen.dart';
import 'package:mvp_game/feature/home/presentation/screen/home_screen.dart';
import 'package:mvp_game/feature/type/presentation/controller/game_flow_view_model.dart';
import 'package:mvp_game/feature/type/presentation/screen/game_type_screen_root.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      // 스플래시
      path: RoutePath.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      // 홈
      path: RoutePath.home,
      builder: (context, state) {
        return HomeScreen(
          onTapStartBtn: () => context.push(RoutePath.gameType),
        );
      },
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: HomeScreen(
            onTapStartBtn: () => context.push(RoutePath.gameType),
          ),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            ); // 여기에 원하는 애니메이션을 적용
          },
        );
      },
    ),
    GoRoute(
      // 게임종류
      path: RoutePath.gameType,
      builder: (context, state) {
        return const GameTypeScreenRoot();
      },
    ),
    GoRoute(
      // 레벨선택
      path: RoutePath.levelChoice,
      builder: (context, state) {
        return const GameLevelScreenRoot();
      },
    ),
    GoRoute(
      // 카운트다운
      path: RoutePath.countDown,
      builder: (context, state) {
        return CountDownScreen(
          onFinished: () {
            context.go(RoutePath.game);
          },
        );
      },
    ),
    GoRoute(
      // 게임
      path: RoutePath.game,
      builder: (context, state) {
        final level = context.read<GameFlowViewModel>().selectedLevel;
        return GameScreenRoot(viewModel: GameViewModel(), level: level!);
      },
    ),
    GoRoute(
      // 게임성공
      path: RoutePath.gameSuccess,
      builder: (context, state) {
        return GameSuccessScreen(onTapHome: () => context.go(RoutePath.home));
      },
    ),
    GoRoute(
      // 게임실패
      path: RoutePath.gameFail,
      builder: (context, state) {
        return GameFailScreen(
          onTapHome: () => context.go(RoutePath.home),
          onTapRestart: () => context.go(RoutePath.countDown),
        );
      },
    ),
  ],
);
