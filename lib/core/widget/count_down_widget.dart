// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mvp_game/core/ui/font_styles.dart';

class CountdownWidget extends StatefulWidget {
  final int count;
  final Function(int value) onFinished;
  const CountdownWidget({
    super.key,
    required this.count,
    required this.onFinished,
  });

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late int _start; // 카운트다운 초기값
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _start = widget.count;
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          widget.onFinished(_start);
          _timer.cancel(); // 카운트다운 종료 시 타이머 취소
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 페이지가 종료되면 타이머 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_start', style: FontStyles.headerTextRegular);
  }
}
