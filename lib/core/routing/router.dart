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
import 'package:mvp_game/feature/type/presentation/screen/game_type_screen.dart';

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
        return GameTypeScreen(
          onTapBack: () => context.pop(),
          onTapType: (type) {
            context.go('${RoutePath.levelChoice}?type=${type.name}');
          },
        );
      },
    ),
    GoRoute(
      // 레벨선택
      path: RoutePath.levelChoice,
      builder: (context, state) {
        final type = state.uri.queryParameters['type'];
        return LevelChoiceScreen(
          onTapBack: () => context.pop(),
          onTapLevel: (level) {
            context.go('${RoutePath.countDown}?level=${level.name}&type=$type');
          },
        );
      },
    ),
    GoRoute(
      // 게임
      path: RoutePath.game,
      builder: (context, state) {
        final levelName = state.uri.queryParameters['level'];
        final level = GameLevel.values.byName(levelName ?? 'three');
        return GameScreenRoot(viewModel: GameViewModel(), level: level);
      },
    ),
    GoRoute(
      // 카운트다운
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
