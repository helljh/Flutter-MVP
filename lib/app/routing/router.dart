import 'package:go_router/go_router.dart';
import 'package:mvp_game/app/routing/route_path.dart';
import 'package:mvp_game/presentation/home/screen/home_screen.dart';
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
          onTapBack: context.pop,
          onTapThree: () {
            print('three tapped');
          },
          onTapFour: () {
            print('four tapped');
          },
          onTapFive: () {
            print('five tapped');
          },
        );
      },
    ),
  ],
);
