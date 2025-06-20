import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvp_game/core/routing/router.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/feature/type/presentation/controller/game_flow_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameFlowViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'MVP Game',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('안녕하세요!', style: FontStyles.largeTextRegular)),
    );
  }
}
