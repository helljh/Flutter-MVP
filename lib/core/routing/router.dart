import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/routing/route_path.dart';
import 'package:mvp_game/presentation/game/presentation/screen/game_screen.dart';
import 'package:mvp_game/presentation/game/presentation/widget/count_down_screen.dart';
import 'package:mvp_game/presentation/game/presentation/widget/game_fail_screen.dart';
import 'package:mvp_game/presentation/game/presentation/widget/game_success_screen.dart';
import 'package:mvp_game/presentation/home/presentation/screen/home_screen.dart';
import 'package:mvp_game/presentation/level/screen/level_choice_screen.dart';

final router = GoRouter(
  initialLocation: RoutePath.home,
  routes: [
    GoRoute(
      path: RoutePath.home,
      builder: (context, state) {
        return HomeScreen(
          onTapStartBtn: () => context.push(RoutePath.levelChoice),
        );
      },
    ),
    GoRoute(
      path: RoutePath.levelChoice,
      builder: (context, state) {
        return LevelChoiceScreen(
          onTapBack: () => context.pop(),
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
        return GameScreen(
          level: level,
          onTapRestart:
              () => context.go('${RoutePath.countDown}?level=${level.name}'),
          onTapHome: () => context.go(RoutePath.home),
          onTapBack: () => context.go(RoutePath.levelChoice),
        );
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
