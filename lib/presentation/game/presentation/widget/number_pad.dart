import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvp_game/presentation/game/presentation/widget/game_fail_dialog.dart';
import 'package:mvp_game/presentation/game/presentation/widget/game_success_dialog.dart';

import '../../../../core/ui/font_styles.dart';

class NumberPad extends StatefulWidget {
  final List<int> questionList;
  final bool isAllCountDownFinished;
  final int leftCount;
  final Function(int count) decreaseCount;
  final VoidCallback onTapHome;
  final VoidCallback onTapRestart;

  const NumberPad({
    super.key,
    required this.questionList,
    required this.isAllCountDownFinished,
    required this.leftCount,
    required this.decreaseCount,
    required this.onTapHome,
    required this.onTapRestart,
  });

  @override
  State<NumberPad> createState() => _NumberPadState();
}

class _NumberPadState extends State<NumberPad> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<bool> _cellFlipped;
  int _currentAnswer = 1; // 현재 눌러야 할 숫자
  late int _totalCount;

  @override
  void initState() {
    super.initState();
    _totalCount = widget.leftCount;

    _cellFlipped = List.generate(9, (_) => false);

    _controllers = List.generate(9, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _animations =
        _controllers
            .map(
              (controller) => Tween<double>(begin: 0, end: pi).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInOut),
              ),
            )
            .toList();
  }

  @override
  void didUpdateWidget(covariant NumberPad oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 게임 시작 시 셀 뒤집기
    if (!oldWidget.isAllCountDownFinished && widget.isAllCountDownFinished) {
      _flipAll();
    }
  }

  void _flipAll() {
    for (int i = 0; i < 9; i++) {
      _controllers[i].forward();
      _cellFlipped[i] = true;
    }
  }

  void _flipCell(int index) {
    if (_cellFlipped[index]) {
      _controllers[index].reverse();
    } else {
      _controllers[index].forward();
    }
    setState(() {
      _cellFlipped[index] = !_cellFlipped[index];
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      padding: const EdgeInsets.all(16),
      children: List.generate(9, (index) {
        int number = widget.questionList[index];

        return GestureDetector(
          onTap: () {
            if (widget.isAllCountDownFinished) {
              if (number == _currentAnswer) {
                _flipCell(index); // 정답이면 뒤집기 유지
                _currentAnswer++;
                if (_currentAnswer > 9) {
                  showDialog(
                    barrierDismissible: false,
                    barrierColor: Colors.white,
                    context: context,

                    builder: (context) {
                      return GameSuccessDialog(onTapHome: widget.onTapHome);
                    },
                  );
                }
              } else {
                // 오답이면 잠깐 뒤집었다 다시 뒤집기
                _flipCell(index);
                Future.delayed(const Duration(milliseconds: 600), () {
                  _flipCell(index);
                });
                _totalCount--;
                widget.decreaseCount(_totalCount);
                if (_totalCount == 0) {
                  showDialog(
                    barrierDismissible: false,
                    barrierColor: Colors.black,
                    context: context,
                    builder: (context) {
                      return GameFailDialog(
                        onTapRestart: widget.onTapRestart,
                        onTapHome: widget.onTapHome,
                      );
                    },
                  );
                }
              }
            }
          },
          child: AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              double rotation = _animations[index].value;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(rotation),
                child: Stack(
                  children: [
                    if (rotation <= pi / 2)
                      _buildCell(number)
                    else
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: _buildCell(null),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildCell(int? number) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child:
          number != null
              ? Text(number.toString(), style: FontStyles.mediumTextRegular)
              : const SizedBox.shrink(),
    );
  }
}
