import 'package:flutter/material.dart';
import 'package:mvp_game/core/ui/font_styles.dart';

class CountDownScreen extends StatefulWidget {
  final VoidCallback onFinished;
  const CountDownScreen({super.key, required this.onFinished});

  @override
  State<CountDownScreen> createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  int _currentNumber = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(
      begin: 10,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _startCountdown();
  }

  void _startCountdown() async {
    while (_currentNumber > 0) {
      await _controller.forward();
      await Future.delayed(const Duration(milliseconds: 300));
      await _controller.reverse();
      setState(() {
        _currentNumber--;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onFinished();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,

          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Text(
                  '$_currentNumber',
                  style: FontStyles.headerTextBold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
