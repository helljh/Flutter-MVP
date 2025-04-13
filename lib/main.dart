import 'package:flutter/material.dart';
import 'package:mvp_game/app/routing/router.dart';
import 'package:mvp_game/presentation/home/screen/home_screen.dart';
import 'package:mvp_game/ui/font_styles.dart';

void main() {
  runApp(const MyApp());
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
