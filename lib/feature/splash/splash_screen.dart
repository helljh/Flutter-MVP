import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/routing/route_path.dart';
import 'package:mvp_game/core/ui/font_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0), // 왼쪽에서 시작
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    startAnimation();
  }

  Future<void> startAnimation() async {
    _controller.forward(); // 글자들 동시에 스르륵 등장

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) context.go(RoutePath.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLine('M', "emory Training"),
              const SizedBox(height: 16),
              _buildLine('V', "isual Grid"),
              const SizedBox(height: 16),
              _buildLine('P', "attern Game"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLine(String letter, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(letter, style: FontStyles.titleTextBold),
        const SizedBox(width: 8),
        SlideTransition(
          position: _slideAnimation,
          child: Text(text, style: FontStyles.largeTextRegular),
        ),
      ],
    );
  }
}
