import 'package:flutter/material.dart';

import '../../../ui/font_styles.dart';

class AnimatedFinger extends StatefulWidget {
  const AnimatedFinger({super.key});

  @override
  State<AnimatedFinger> createState() => _AnimatedFingerState();
}

class _AnimatedFingerState extends State<AnimatedFinger>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 24),
        SlideTransition(
          position: _animation,
          child: Image.asset(
            'assets/images/finger.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
