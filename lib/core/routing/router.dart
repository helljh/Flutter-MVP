import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/routing/route_path.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_view_model.dart';
import 'package:mvp_game/feature/game/presentation/screen/game_screen_root.dart';
import 'package:mvp_game/feature/game/presentation/widget/count_down_screen.dart';
import 'package:mvp_game/feature/splash/splash_screen.dart';
import 'package:mvp_game/feature/success/game_success_screen.dart';
import 'package:mvp_game/feature/level/presentation/screen/level_choice_screen.dart';
import 'package:mvp_game/feature/presentation/widget/game_fail_screen.dart';
import 'package:mvp_game/feature/home/presentation/screen/home_screen.dart';

final router = GoRouter(
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePath.home,
      builder: (context, state) {
        return HomeScreen(
          onTapStartBtn: () => context.push(RoutePath.levelChoice),
        );
      },
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: HomeScreen(
            onTapStartBtn: () => context.push(RoutePath.levelChoice),
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
      path: RoutePath.levelChoice,
      builder: (context, state) {
        return LevelChoiceScreen(
          onTapBack: () => context.go(RoutePath.home),
          onTapLevel: (level) {
            context.go('${RoutePath.countDown}?level=${level.name}');
          },
        );
      },
    ),
    GoRoute(
      path: RoutePath.game,
      builder: (context, state) {
        final levelName = state.uri.queryParameters['level'];
        final level = GameLevel.values.byName(levelName ?? 'three');
        return GameScreenRoot(viewModel: GameViewModel(), level: level);
      },
    ),
    GoRoute(
      path: RoutePath.countDown,
      builder: (context, state) {
        final levelName = state.uri.queryParameters['level'];
        final level = GameLevel.values.byName(levelName ?? 'three');
        return CountDownScreen(
          onFinished: () {
            context.go('${RoutePath.game}?level=${level.name}');
          },
        );
      },
    ),
    GoRoute(
      path: RoutePath.gameSuccess,
      builder: (context, state) {
        return GameSuccessScreen(onTapHome: () => context.go(RoutePath.home));
      },
    ),
    GoRoute(
      path: RoutePath.gameFail,
      builder: (context, state) {
        final level = state.extra as int;
        return GameFailScreen(
          onTapHome: () => context.go(RoutePath.home),
          onTapRestart:
              () => context.go(
                '${RoutePath.countDown}?level=${GameLevel.parse(level).name}',
              ),
        );
      },
    ),
  ],
);
